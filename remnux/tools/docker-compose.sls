{% set version = "5.0.2" %}
{% set hash = "2d880f723d3da7c779c54fdaea91a842fca8af55d1397f1ed8d7cbab3dd7af67" %}

docker-compose-source:
  file.managed:
    - name: /usr/bin/docker-compose
    - source: https://github.com/docker/compose/releases/download/v{{ version }}/docker-compose-linux-x86_64
    - source_hash: sha256={{ hash }}
    - makedirs: False
    - mode: 755

