{% from "remnux/osarch.sls" import osarch with context %}
{% set version = "5.0.2" %}
{% if osarch == "arm64" %}
  {% set arch = "aarch64" %}
  {% set hash = "ac7810e0cd56a5b58576688196fafa843e07e8241fb91018a736d549ea20a3f3" %}
{% else %}
  {% set arch = "x86_64" %}
  {% set hash = "2d880f723d3da7c779c54fdaea91a842fca8af55d1397f1ed8d7cbab3dd7af67" %}
{% endif %}

docker-compose-source:
  file.managed:
    - name: /usr/bin/docker-compose
    - source: https://github.com/docker/compose/releases/download/v{{ version }}/docker-compose-linux-{{ arch }}
    - source_hash: sha256={{ hash }}
    - makedirs: False
    - mode: 755

