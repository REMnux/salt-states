include:
  - remnux.repos.docker

docker-docker-engine:
  pkg.removed:
    - name: docker-engine

docker-docker-ce:
  pkg.installed:
    - name: docker-ce
    - require:
      - pkg: docker-docker-engine
      - sls: remnux.repos.docker
