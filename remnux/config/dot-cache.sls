# Sometimes subdirectories under .cache end up owned by root. Let's fix that.

{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}


{% if user != "root" %}

{% set home = "/home/" + user  %}

include:
  - remnux.config.user

remnux-dot-cache-owner:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.cache
    - makedirs: True
    - recurse:
      - user
      - group
    - require:
      - user: remnux-user-{{ user }}

{% endif %}