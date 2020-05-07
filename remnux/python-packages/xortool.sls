include:
  - remnux.packages.python-pip

xortool:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
