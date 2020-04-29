# Name: thug
# Website: https://github.com/buffer/thug
# Description: Python-based low-interaction honeyclient
# Category: Examine browser malware: Websites
# Author: Angelo Dell'Aera
# License: https://github.com/buffer/thug/blob/master/LICENSE.txt
# Notes: thug -F

include:
  - remnux.packages.git
  - remnux.packages.python3
  - remnux.packages.python3-setuptools
  - remnux.packages.libemu-dev
  - remnux.packages.libgraphviz-dev
  - remnux.python-packages.stpyv8

remnux-git-thug:
  git.cloned:
    - name: https://github.com/buffer/thug
    - target: /usr/local/src/thug

remnux-python-build-thug:
  cmd.run:
    - name: /usr/bin/python3 setup.py build
    - cwd: /usr/local/src/thug/
    - require:
      - sls: remnux.packages.python3
      - sls: remnux.packages.python3-setuptools
      - sls: remnux.python-packages.stpyv8
    - watch:
      - git: remnux-git-thug

remnux-python-thug:
  cmd.run:
    - name: /usr/bin/python3 setup.py install
    - cwd: /usr/local/src/thug/
    - require:
      - sls: remnux.packages.libemu-dev
      - sls: remnux.packages.libgraphviz-dev
    - watch:
      - cmd: remnux-python-build-thug