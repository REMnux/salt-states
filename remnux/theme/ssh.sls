{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}

include:
  - remnux.packages.openssh-server

remnux-theme-ssh-sshd-disable-usedns:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^UseDNS no$
    - require:
      - sls: remnux.packages.openssh-server

remnux-theme-ssh-sshd-disable-gssapi:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^GSSAPIAuthentication no$
    - require:
      - sls: remnux.packages.openssh-server


# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

remnux-theme-ssh-sshd-disable-service:
  service.dead:
    - name: ssh
    - enable: False
    - require:
      - sls: remnux.packages.openssh-server

{% endif %}