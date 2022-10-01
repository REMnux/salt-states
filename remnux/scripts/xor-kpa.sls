# Name: xor-kpa.py
# Website: https://blog.didierstevens.com/2017/06/06/update-xor-kpa-py-version-0-0-5/
# Description: Implement a XOR known plaintext attack.
# Category: Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: 

remnux-scripts-xor-kpa-source:
  file.managed:
    - name: /usr/local/src/remnux/files/xor-kpa_V0_0_6.zip
    - source: https://didierstevens.com/files/software/xor-kpa_V0_0_6.zip
    - source_hash: F7BE170D09E8B8A5B4127F64EC66FFF69EFD3EFA3B4EAC0304B39905A75CDE2A
    - makedirs: True

remnux-scripts-xor-kpa-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/xor-kpa_V0_0_6
    - source: /usr/local/src/remnux/files/xor-kpa_V0_0_6.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-xor-kpa-source

remnux-scripts-xor-kpa-binary:
  file.managed:
    - name: /usr/local/bin/xor-kpa.py
    - source: /usr/local/src/remnux/xor-kpa_V0_0_6/xor-kpa.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-xor-kpa-archive

remnux-scripts-xor-kpa-shebang:
  file.replace:
    - name: /usr/local/bin/xor-kpa.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-xor-kpa-binary
