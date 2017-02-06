include:
  - remnux.python-packages.pip

docker-compose:
  pip.installed:
    - require:
      - pip: pip
