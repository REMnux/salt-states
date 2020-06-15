{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user != "root" %}


include:
  - remnux.config.user
  - remnux.packages.wireshark

remnux-theme-wireshark-reconfigure:
  cmd.run:
    - name: echo "wireshark-common wireshark-common/install-setuid select True"| debconf-set-selections; dpkg-reconfigure -f noninteractive wireshark-common
    - watch:
        - sls: remnux.packages.wireshark

remnux-theme-wireshark-group:
  group.present:
    - name: wireshark
    - system: True
    - members:
        - {{ user }}
    - watch:
      - cmd: remnux-theme-wireshark-reconfigure
    - require:
      - user: remnux-user-{{ user }}

{% endif %}