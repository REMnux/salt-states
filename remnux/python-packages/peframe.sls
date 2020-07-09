# Name: PEframe
# Website: https://github.com/guelfoweb/peframe
# Description: Statically analyze PE and Microsoft Office files.
# Category: Examine Static Properties: PE Files
# Author: Gianni Amato: https://twitter.com/guelfoweb
# License: Free, unknown license
# Notes: 

include:
  - remnux.packages.git
  - remnux.packages.libssl-dev
  - remnux.packages.swig
  - remnux.packages.python3-pip
  - remnux.packages.python-pip

remnux-pip-peframe:
  pip.installed:
    - name: git+https://github.com/guelfoweb/peframe.git@master
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.swig
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python-pip
