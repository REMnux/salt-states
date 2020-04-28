{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}           

include:
  - remnux.config.user
  - remnux.python-packages.thug

remnux-config-thug:
  file.directory:
    - name: /var/log/thug
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - makedirs: True
- require:
    - user: remnux-user-{{ user }}
- watch:
    - pkg: remnux-python-thug
