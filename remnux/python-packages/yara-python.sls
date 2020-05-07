include:
  - remnux.packages.python-pip

yara-python:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip