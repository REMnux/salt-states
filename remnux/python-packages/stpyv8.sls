# Name: STPyV8
# Website: https://github.com/area1/stpyv8
# Description: Python3 and JavaScript interop engine, fork of the original PyV8 project
# Category: Examine browser malware: Websites
# Author: Area1 Security
# License: https://github.com/area1/stpyv8/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.git
  - remnux.packages.python3
  - remnux.packages.python
  - remnux.packages.sudo
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-system-dev
  - remnux.packages.libboost-dev
  - remnux.packages.python3-setuptools
  - remnux.packages.python-setuptools
  - remnux.packages.build-essential
  - remnux.packages.python3-pip

remnux-git-stpyv8:
  git.cloned:
    - name: https://github.com/area1/stpyv8
    - target: /usr/local/src/stpyv8

remnux-pip3-stpyv8:
  cmd.run:
    - cwd: /usr/local/src/stpyv8/
    - name: /usr/bin/pip3 install wheels/ubuntu-18.04/stpyv8-7.9.317.33-cp36-cp36m-linux_x86_64.whl
    - require:
      - sls: remnux.packages.python3
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.sudo
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-system-dev
      - sls: remnux.packages.libboost-dev
    - watch:
      - git: remnux-git-stpyv8
