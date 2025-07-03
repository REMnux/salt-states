{% set version = "2.37.3" %}
{% set hash = "522181c447d831fb23134201d9cdc5cf365f913408124c678089ea62d6a2334c" %}

docker-compose-source:
  file.managed:
    - name: /usr/bin/docker-compose
    - source: https://github.com/docker/compose/releases/download/v{{ version }}/docker-compose-linux-x86_64
    - source_hash: sha256={{ hash }}
    - makedirs: False
    - mode: 755

