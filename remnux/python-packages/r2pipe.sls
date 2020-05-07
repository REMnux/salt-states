include:
  - remnux.packages.python-pip

r2pipe:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
