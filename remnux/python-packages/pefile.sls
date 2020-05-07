include:
  - remnux.packages.python-pip

pefile:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
