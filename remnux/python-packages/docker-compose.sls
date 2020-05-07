include:
  - remnux.packages.python-pip

docker-compose:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
