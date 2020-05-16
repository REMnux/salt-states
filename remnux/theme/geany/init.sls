{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}

{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else %}
  {%- set home = "/home/" + user -%}
{%- endif -%}

include:
  - remnux.config.user
  - remnux.packages.geany

remnux-theme-geany-config:
  file.managed:
    - replace: False
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.config/geany/geany.conf
    - source: salt://remnux/theme/geany/geany.conf
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}
      - sls: remnux.packages.geany