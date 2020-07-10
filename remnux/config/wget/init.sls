{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}         

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.config.user
  - remnux.packages.wget

remnux-config-wget:
  file.managed:
    - name: {{ home }}/.wgetrc
    - source: salt://remnux/config/wget/wgetrc
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - pkg: remnux-packages-wget
