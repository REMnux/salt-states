# Sometimes subdirectories under .config end up owned by root. Let's fix that.

{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}


{% if user != "root" %}

{% set home = "/home/" + user  %}

include:
  - remnux.config.user

remnux-dot-config-owner:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.config
    - makedirs: True
    - recurse:
      - user
      - group
    - require:
      - user: remnux-user-{{ user }}

{% endif %}