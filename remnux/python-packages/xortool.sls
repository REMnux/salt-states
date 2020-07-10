# Name: xortool
# Website: https://github.com/hellman/xortool
# Description: Analyze XOR-encoded data.
# Category: Examine Static Properties: Deobfuscation
# Author: Aleksei Hellman
# License: MIT License: https://github.com/hellman/xortool/blob/master/LICENSE
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
