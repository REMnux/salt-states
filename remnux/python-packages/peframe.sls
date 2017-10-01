# Source:  https://github.com/guelfoweb/peframe
# Author: Gianni 'guelfoweb' Amato

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.python-packages.simplejson

remnux-pip-peframe:
  pip.installed:
    - name: git+https://github.com/guelfoweb/peframe.git@master
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.python-packages.simplejson
