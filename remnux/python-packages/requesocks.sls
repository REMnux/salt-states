include:
  - remnux.packages.python-pip

requesocks:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
