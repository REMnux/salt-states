include:
  - remnux.packages.python-pip

pypssl:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
