include:
  - remnux.python-packages.pip

oletools:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
