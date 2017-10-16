remnux-package-curl:
  pkg.installed:
    - name: curl

{% set home = salt['environ.get']('HOME') %}
{% set user = salt['environ.get']('SUDO_USER') %}

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
    - user: {{ user }}
    - group: {{ user }}
    - watch:
        - file: remnux-packages-curl-config

{% endif %}

