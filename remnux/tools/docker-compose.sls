{% set version = "2.23.3" %}
{% set hash = "a836e807951db448f991f303cddcc9a4ec69f4a49d58bc7d536cb91c77c04c33" %}

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

