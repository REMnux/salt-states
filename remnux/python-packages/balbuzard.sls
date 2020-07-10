# Name: Balbuzard
# Website: https://github.com/decalage2/balbuzard
# Description: Extract and deobfuscate patterns from suspicious files.
# Category: Examine Static Properties: Deobfuscation
# Author: Philippe Lagadec: https://twitter.com/decalage2
# License: Free, custom license: https://github.com/decalage2/balbuzard
# Notes: balbuzard, bbcrack, bbharvest, bbtrans

include:
  - remnux.packages.python-pip
  - remnux.python-packages.yara-python

remnux-python-packages-balbuzard:
  pip.installed:
    - name: balbuzard
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.python-packages.yara-python