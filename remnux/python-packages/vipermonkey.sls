# Name: ViperMonkey
# Website: https://www.decalage.info/en/vba_emulation
# Description: A VBA parser and emulation engine to analyze malicious macros
# Category: Examine document files: Microsoft Office
# Author: Philippe Lagadec
# License: https://github.com/decalage2/ViperMonkey#license
# Notes: vmonkey

include:
  - remnux.packages.python-pip
  - remnux.packages.git

remnux-pip-vipermonkey:
  pip.installed:
    - name: git+https://github.com/decalage2/ViperMonkey.git
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.git

