include:
  - remnux.packages.python-pip

rarfile:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
