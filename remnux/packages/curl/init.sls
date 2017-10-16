curl:
  pkg.installed

{% set home = salt['environ.get']('HOME') %}
{% set sudo_user = salt['environ.get']('SUDO_USER') %}

{% if home %}
remnux-packages-curl-config:
  file.managed:
    - name: {{ home }}/.curlrc
    - source: salt://remnux/packages/curl/curlrc
    - makedirs: False
    - watch:
        - pkg: curl

remnux-packages-curl-ownership:
  file.managed:
    - name: {{ home }}/.curlrc
    - user: {{ sudo_user }}
    - group: {{ sudo_user }}
    - watch:
        - file: remnux-packages-curl-config

{% endif %}

