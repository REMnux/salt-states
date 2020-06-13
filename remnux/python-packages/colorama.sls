include:
  - remnux.packages.python-pip

colorama:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
