{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}           

{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

include:
  - remnux.config.user

remnux-config-bash-aliases:
  file.managed:
    - name: {{ home }}/.bash_aliases
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: remnux-user-{{ user }}