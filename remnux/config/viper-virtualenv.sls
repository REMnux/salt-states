{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.config.user
  - remnux.python3-packages.viper-framework

remnux-config-viper-framework-virtualenv-permissions:
  file.directory:
    - name: /opt/viper
    - makedirs: False
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: remnux-user-{{ user }}
    - require:
      - sls: remnux.python3-packages.viper-framework
