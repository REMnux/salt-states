{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}           

include:
  - remnux.config.user
  - remnux.packages.curl

remnux-config-curl:
  file.managed:
    - name: {{ salt['user.info'](user).home }}/.curlrc
    - source: salt://remnux/config/curl/curlrc
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - pkg: remnux-package-curl
