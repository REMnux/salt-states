include:
  - remnux.packages.python-pip

bottle:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
