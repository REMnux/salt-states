include:
  - remnux.packages.python-pipp

olefile:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
