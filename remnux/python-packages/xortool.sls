# Name: xortool
# Website: https://github.com/hellman/xortool
# Description: Python 3 tool for XOR analysis
# Category: Artifact Extraction and Decoding: Deobfuscate
# Author: Aleksei Hellman
# License: https://github.com/hellman/xortool/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

xortool:
  pip.installed:
    - pip_bin: /usr/bin/python3
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python3-pip
