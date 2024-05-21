{% set version = "2.27.0" %}
{% set hash = "f3ba3bf1e4ab18e96c2d36526a075a02a78fb5f8e80d3e3ca9c5bf256d81d0a0" %}

include:
  - remnux.python3-packages.pip

docker-compose-source:
  file.managed:
    - name: /usr/bin/docker-compose
    - source: https://github.com/docker/compose/releases/download/v{{ version }}/docker-compose-linux-x86_64
    - source_hash: sha256={{ hash }}
    - makedirs: False
    - mode: 755
    - require:
      - sls: remnux.python3-packages.pip

