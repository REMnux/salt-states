include:
  - remnux.packages.python-pip

pype32:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
