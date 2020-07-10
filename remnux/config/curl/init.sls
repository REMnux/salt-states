{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}       

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.config.user
  - remnux.packages.curl

remnux-config-curl:
  file.managed:
    - name: {{ home }}/.curlrc
    - source: salt://remnux/config/curl/curlrc
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - pkg: remnux-packages-curl
