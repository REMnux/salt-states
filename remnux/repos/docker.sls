include:
  - remnux.packages.apt-transport-https

docker:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ grains['lsb_distrib_codename'] }} stable
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88
    - keyserver: p80.pool.sks-keyservers.net
    - refresh_db: true
    - require:
      - sls: remnux.packages.apt-transport-https
