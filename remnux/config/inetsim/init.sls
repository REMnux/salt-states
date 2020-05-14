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