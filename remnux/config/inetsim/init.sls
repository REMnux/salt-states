include:
  - remnux.packages.inetsim

remnux-config-inetsim:
  file.managed:
    - name: /etc/inetsim/inetsim.conf
    - source: salt://remnux/config/inetsim/inetsim.conf
    - user: root
    - group: root
    - makedirs: True
    - require:
      - sls: remnux.packages.inetsim

remnux-config-inetsim-permissions:
  file.managed:
    - name: /var/lib/inetsim/certs/default_key.pem
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.packages.inetsim

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

remnux-config-inetsim-service:
  service.dead:
    - name: inetsim
    - enable: False
    - require:
      - sls: remnux.packages.inetsim

{% endif %}

# INetSim 1.3.2 calls Net::DNS::Nameserver->main_loop(), which Net::DNS 1.40+
# turned into a wrapper around start_server(). start_server() croaks when called
# from a forked child -- and INetSim forks one child per service -- so the DNS
# service dies immediately while INetSim still reports it as started.
# See https://github.com/REMnux/salt-states/issues/356
#
# Note: this edits a file owned by the inetsim package, so "dpkg --verify inetsim"
# will report DNS.pm as modified. An inetsim upgrade reverts it; the next
# "remnux install" re-applies it. If Ubuntu ever ships a fixed inetsim, the patch
# stops applying and this state fails loudly rather than failing silently.
remnux-config-inetsim-patch-util:
  pkg.installed:
    - name: patch

# Guard: the patch relies on Net::DNS::Nameserver->loop_once(), which upstream
# also marks "historical". If a future Net::DNS drops it, stop here rather than
# applying a patch that would leave the DNS service silently broken.
remnux-config-inetsim-netdns-loop-once-present:
  cmd.run:
    - name: "perl -MNet::DNS::Nameserver -e 'die q{Net::DNS::Nameserver->loop_once() is gone; INetSim DNS patch needs rework}'"
    - unless: "perl -MNet::DNS::Nameserver -e 'exit(Net::DNS::Nameserver->can(q{loop_once}) ? 0 : 1)'"
    - require:
      - sls: remnux.packages.inetsim

remnux-config-inetsim-dns-netdns-compat:
  file.patch:
    - name: /usr/share/perl5/INetSim/DNS.pm
    - source: salt://remnux/config/inetsim/inetsim-dns-netdns-compat.patch
    - require:
      - sls: remnux.packages.inetsim
      - pkg: remnux-config-inetsim-patch-util
      - cmd: remnux-config-inetsim-netdns-loop-once-present