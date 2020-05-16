# Sometimes .bash_history ends up owned by root. Let's fix that.

{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user != "root" %}

{% set home = "/home/" + user  %}


include:
  - remnux.config.user

remnux-config-bash-history:
  file.managed:
    - replace: False
    - name: {{ home }}/.bash_history
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: remnux-user-{{ user }}

  {% endif %}