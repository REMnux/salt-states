{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.config.user
  - remnux.packages.binee

remnux-config-binee-owner:
  file.directory:
    - name: /opt/binee-files/win10_32/windows/system32
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - user: remnux-user-{{ user }}
    - require:
      - sls: remnux.packages.binee