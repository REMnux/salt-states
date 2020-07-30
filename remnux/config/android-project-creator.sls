{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.config.user
  - remnux.packages.android-project-creator

remnux-config-android-project-creator-permissions:
  file.directory:
    - name: /opt/AndroidProjectCreator/library
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - user: remnux-user-{{ user }}
    - require:
      - sls: remnux.packages.android-project-creator