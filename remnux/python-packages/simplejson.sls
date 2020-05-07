include:
  - remnux.packages.python-pip

simplejson:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
