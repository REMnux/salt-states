include:
  - remnux.repos.docker

docker-engine:
  pkg.installed:
    - require:
      - pkgrepo: docker
