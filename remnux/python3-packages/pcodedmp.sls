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

remnux-python3-packages-pcodedmp-shebang:
  file.replace:
    - name: /usr/local/bin/pcodedmp
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - pip: pcodedmp
