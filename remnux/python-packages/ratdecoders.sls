# Name: RATDecoders
# Website: https://github.com/kevthehermit/RATDecoders
# Description: Python3 Decoders for Remote Access Trojans
# Category: Statically examine PE files: Investigate
# Author: Kevin Breen
# License: https://github.com/kevthehermit/RATDecoders/blob/master/LICENSE
# Notes: malconf

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.git
  - remnux.python-packages.androguard
  - remnux.python-packages.yara-python3

remnux-ratdecoders-install:
  pip.installed:
    - name: git+https://github.com/kevthehermit/RATDecoders.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git
      - sls: remnux.python-packages.androguard
      - sls: remnux.python-packages.yara-python3
