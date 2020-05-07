include:
  - remnux.packages.python-pip

pydeep:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip