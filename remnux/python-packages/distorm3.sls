include:
  - remnux.packages.python-pip

distorm3:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
