include:
  - remnux.packages.pip

oletools:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
