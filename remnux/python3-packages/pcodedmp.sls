# Name: pcodedmp
# Website: https://github.com/bontchev/pcodedmp
# Description: Disassemble VBA p-code
# Category: Analyze Documents: Microsoft Office
# Author: Vesselin Bontchev: https://twitter.com/bontchev
# License: GNU General Public License (GPL) v3: https://github.com/bontchev/pcodedmp/blob/master/LICENSE
# Notes:

include:
  - remnux.python3-packages.pip

pcodedmp:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
