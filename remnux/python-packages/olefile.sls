include:
  - remnux.packages.python-pip

olefile:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
