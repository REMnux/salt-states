{% from "remnux/osarch.sls" import osarch with context %}
remnux-docker-key:
  file.managed:
    - name: /usr/share/keyrings/DOCKER-PGP-KEY.asc
    - source: https://download.docker.com/linux/ubuntu/gpg
    - skip_verify: True
    - makedirs: True

remnux-remove-docker-ppa:
  pkgrepo.absent:
    - ppa: docker/stable

remnux-remove-docker-list:
  file.absent:
    - name: /etc/apt/sources.list.d/docker.list
    - require:
      - pkgrepo: remnux-remove-docker-ppa

remnux-remove-docker-sources:
  file.absent:
    - name: /etc/apt/sources.list.d/docker.sources
    - require:
      - pkgrepo: remnux-remove-docker-ppa

remnux-docker-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/docker.sources
    - contents: |
        Types: deb
        URIs: https://download.docker.com/linux/ubuntu
        Suites: {{ grains['lsb_distrib_codename'] }}
        Components: stable
        Signed-By: /usr/share/keyrings/DOCKER-PGP-KEY.asc
        Architectures: {{ osarch }}
    - require:
      - file: remnux-docker-key
      - pkgrepo: remnux-remove-docker-ppa
      - file: remnux-remove-docker-list
      - file: remnux-remove-docker-sources
