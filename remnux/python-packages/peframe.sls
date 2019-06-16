# Source:  https://github.com/guelfoweb/peframe
# Author: Gianni 'guelfoweb' Amato

include:
  - remnux.packages.git
  - remnux.packages.libssl-dev
  - remnux.packages.swig
  - remnux.packages.python3-pip

remnux-pip-peframe:
  pip.installed:
    - name: git+https://github.com/guelfoweb/peframe.git@master
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.swig
      - sls: remnux.packages.python3-pip
