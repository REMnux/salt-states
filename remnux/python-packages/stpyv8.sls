# Name: STPyV8
# Website: https://github.com/area1/stpyv8
# Description: Python3 and JavaScript interop engine, fork of the original PyV8 project
# Category: Examine browser malware: Websites
# Author: Area1 Security
# License: https://github.com/area1/stpyv8/blob/master/LICENSE.txt
# Notes: Required for thug

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

remnux-git-stpyv8:
  git.cloned:
    - name: https://github.com/area1/stpyv8
    - target: /usr/local/src/stpyv8

remnux-python-v8:
  cmd.run:    
    - name: /usr/bin/python setup.py v8
    - cwd: /usr/local/src/stpyv8/
    - require:
      - sls: remnux.packages.python
    - watch:
      - git: remnux-git-stpyv8

remnux-python-build-stpyv8:
  cmd.run:
   - name: /usr/bin/python3 setup.py stpyv8
   - cwd: /usr/local/src/stpyv8/
   - require:
     - sls: remnux.packages.python3
     - sls: remnux.packages.sudo
     - sls: remnux.packages.libboost-python-dev
     - sls: remnux.packages.libboost-system-dev
     - sls: remnux.packages.libboost-dev
   - watch:
      - cmd: remnux-python-v8

remnux-python-stpyv8:
  cmd.run:
   - name: /usr/bin/python3 setup.py install
   - cwd: /usr/local/src/stpyv8/
   - require:
     - sls: remnux.packages.python3
   - watch:
      - cmd: remnux-python-build-stpyv8