# Name: Volatility 3
# Website: https://github.com/volatilityfoundation/volatility3
# Description: Memory forensics tool and framework
# Category: Perform Memory Forensics
# Author: The Volatility Foundation
# License: Volatility Software License: https://github.com/volatilityfoundation/volatility3/blob/master/LICENSE.txt
# Notes: vol3, volshell3

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.python-packages.pefile
  - remnux.packages.python3-pip

remnux-python-packages-volatility3:
  pip.installed:
    - name: git+https://github.com/volatilityfoundation/volatility3.git@master
    - pip_bin: /usr/bin/python3
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python3-pip
      - sls: remnux.python-packages.pefile

remnux-python-packages-volatility-rename-vol:
  file.rename:
    - name: /usr/local/bin/vol3
    - source: /usr/local/bin/vol
    - force: true
    - makedirs: True
    - watch:
      - pip: remnux-python-packages-volatility3

remnux-python-packages-volatility-rename-volshell:
  file.rename:
    - name: /usr/local/bin/volshell3
    - source: /usr/local/bin/volshell
    - force: true
    - makedirs: True
    - watch:
      - pip: remnux-python-packages-volatility3