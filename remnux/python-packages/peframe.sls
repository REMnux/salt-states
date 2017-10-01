# Source:  https://github.com/guelfoweb/peframe
# Commit:  e482def
# Version: 5.0.1
include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.python-packages.simplejson

remnux-pip-peframe:
  pip.installed:
    - name: git+https://github.com/guelfoweb/peframe.git@e482def
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.python-packages.simplejson
