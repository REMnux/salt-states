# Name: sortcanon.py
# Website: https://blog.didierstevens.com/2022/06/18/new-tool-sortcanon-py/
# Description: Sort text files using canonicalization functions built into this tool.
# Category: General Utilities
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

include:
  - remnux.packages.python3

remnux-scripts-sortcanon-source:
  file.managed:
    - name: /usr/local/src/remnux/files/sortcanon_V0_0_2.zip
    - source: https://didierstevens.com/files/software/sortcanon_V0_0_2.zip
    - source_hash: 190922F347AC1B32D0CE503D1763F27A250D9BFDD15CB911EA4435BAB7E69CD3
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-sortcanon-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/sortcanon_V0_0_2
    - source: /usr/local/src/remnux/files/sortcanon_V0_0_2.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-sortcanon-source

remnux-scripts-sortcanon-shebang:
  file.replace:
    - name: /usr/local/src/remnux/sortcanon_V0_0_2/sortcanon.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - archive: remnux-scripts-sortcanon-archive

remnux-scripts-sortcanon-binary:
  file.managed:
    - name: /usr/local/bin/sortcanon.py
    - source: /usr/local/src/remnux/sortcanon_V0_0_2/sortcanon.py
    - mode: 755
    - watch:
      - file: remnux-scripts-sortcanon-shebang
