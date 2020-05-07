include:
  - remnux.packages.python-pip

pylzma:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
