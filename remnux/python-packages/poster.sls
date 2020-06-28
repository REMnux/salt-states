include:
  - remnux.packages.python-pip

poster:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
