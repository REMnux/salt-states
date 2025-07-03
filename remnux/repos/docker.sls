{% from "remnux/osarch.sls" import osarch with context %}
remnux-docker-key:
  file.managed:
    - name: /usr/share/keyrings/DOCKER-PGP-KEY.asc
    - source: https://download.docker.com/linux/ubuntu/gpg
    - skip_verify: True
    - makedirs: True

remnux-docker-repo:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/DOCKER-PGP-KEY.asc] https://download.docker.com/linux/ubuntu {{ grains['lsb_distrib_codename'] }} stable
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/docker.list
    - refresh: True
    - clean_file: True
    - require:
      - file: remnux-docker-key
