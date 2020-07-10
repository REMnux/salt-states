# Name: STPyV8
# Website: https://github.com/area1/stpyv8
# Description: Python3 and JavaScript interop engine, fork of the original PyV8 project
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Area1 Security
# License: Apache License 2.0: https://github.com/area1/stpyv8/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.python3
  - remnux.packages.python
  - remnux.packages.sudo
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-system-dev
  - remnux.packages.libboost-dev
  - remnux.packages.python3-setuptools
  - remnux.packages.python-setuptools
  - remnux.packages.build-essential
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-pip3-stpyv8:
  pip.installed:
    - name: https://github.com/area1/stpyv8/releases/download/v8.3.110.13/stpyv8-8.3.110.13-cp36-cp36m-linux_x86_64.whl
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.sudo
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-system-dev
      - sls: remnux.packages.libboost-dev
