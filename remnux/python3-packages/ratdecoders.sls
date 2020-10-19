# Name: RATDecoders
# Website: https://github.com/kevthehermit/RATDecoders
# Description: Python3 Decoders for Remote Access Trojans
# Category: Examine Static Properties: Deobfuscation
# Author: Kevin Breen: https://twitter.com/KevTheHermit
# License: MIT License: https://github.com/kevthehermit/RATDecoders/blob/master/LICENSE
# Notes: malconf

include:
  - remnux.packages.python3-pip
  - remnux.packages.git
  - remnux.python3-packages.androguard
  - remnux.python3-packages.yara-python3

remnux-python3-packages-ratdecoders:
  pip.installed:
    - name: malwareconfig
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git
      - sls: remnux.python3-packages.androguard
      - sls: remnux.python3-packages.yara-python3
