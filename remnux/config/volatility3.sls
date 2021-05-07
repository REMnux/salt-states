{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.config.user
  - remnux.python3-packages.volatility3

remnux-config-volatility3-permissions:
  file.directory:
    - name: /usr/local/lib/python3.8/dist-packages/volatility3/framework/symbols
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - recurse:
        - user
        - group
    - mode: 755
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - pip: remnux-python3-packages-volatility3