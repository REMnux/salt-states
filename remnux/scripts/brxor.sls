# Name: brxor.py
# Website: https://github.com/REMnux/distro/blob/master/files/brxor.py
# Description: Bruteforce XOR'ed strings to find those that are English words.
# Category: Examine Static Properties: Deobfuscation
# Author: Alexander Hanel, Trenton Tait
# License: Free, unknown license
# Notes: 

include:
  - remnux.packages.enchant
  - remnux.python-packages.pyenchant

remnux-scripts-brxor-source:
  file.managed:
    - name: /usr/local/bin/brxor.py
    - source: https://github.com/REMnux/distro/raw/master/files/brxor.py
    - source_hash: sha256=f9973f999a01dc7ab3f7f6a4a21df4224d4068b6dcdd8de2aaab4fe1be200d18
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.enchant
      - sls: remnux.python-packages.pyenchant

remnux-scripts-brxor-shebang:
  file.replace:
    - name: /usr/local/bin/brxor.py
    - pattern: '#!/usr/bin/python'
    - repl: '#!/usr/bin/env python2'
    - count: 1
    - backup: False
    - prepend_if_not_found: False
    - watch:
      - file: remnux-scripts-brxor-source

