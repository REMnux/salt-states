include:
  - remnux.packages.python-pip

construct:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
