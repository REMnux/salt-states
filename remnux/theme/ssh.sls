{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}

include:
  - remnux.packages.openssh

remnux-theme-ssh-sshd-disable-usedns:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^UseDNS no$
    - require:
      - sls: remnux.packages.openssh

remnux-theme-ssh-sshd-disable-gssapi:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^GSSAPIAuthentication no$
    - require:
      - sls: remnux.packages.openssh