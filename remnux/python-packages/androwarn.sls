# Name: Androwarn
# Website: https://github.com/maaaaz/androwarn
# Description: Static code analyzer for malicious Android applications
# Category: Investigate mobile malware
# Author: Thomas Debize
# License: https://github.com/maaaaz/androwarn/blob/master/COPYING
# Notes: 

include:
  - remnux.packages.python-pip

remnux-androwarn-install:
  pip.installed:
    - name: androwarn
    - require:
      - sls: remnux.packages.python-pip
