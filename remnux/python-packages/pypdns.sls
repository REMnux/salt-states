include:
  - remnux.packages.python-pip

pypdns:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
