{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}           

include:
  - remnux.config.user
  - remnux.packages.wget

remnux-config-wget:
  file.managed:
    - name: {{ salt['user.info'](user).home }}/.wgetrc
    - source: salt://remnux/config/wget/wgetrc
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - pkg: remnux-package-wget
