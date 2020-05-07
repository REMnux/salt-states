include:
  - remnux.packages.python-pip

wheel:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
