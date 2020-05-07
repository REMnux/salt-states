include:
  - remnux.packages.python-pip

ndg-httpsclient:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
