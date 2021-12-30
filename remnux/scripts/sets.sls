# Name: sets.py
# Website: https://blog.didierstevens.com/2017/03/05/new-tool-sets-py/
# Description: Perform set operations on lines or bytes in text files.
# Category: Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: 

include:
  - remnux.packages.python3

remnux-scripts-sets-source:
  file.managed:
    - name: /usr/local/src/remnux/files/sets_V0_0_3.zip
    - source: https://didierstevens.com/files/software/sets_V0_0_3.zip
    - source_hash: sha256=94200F8313A66D7CAB6C200A24DD6A5B1D9644004C2ECCF01F22004A801EFE03
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-sets-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/sets_V0_0_3
    - source: /usr/local/src/remnux/files/sets_V0_0_3.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-sets-source

remnux-scripts-sets-binary:
  file.managed:
    - name: /usr/local/bin/sets.py
    - source: /usr/local/src/remnux/sets_V0_0_3/sets.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-sets-archive

remnux-scripts-sets-shebang:
  file.replace:
    - name: /usr/local/bin/sets.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/env python3'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-sets-binary