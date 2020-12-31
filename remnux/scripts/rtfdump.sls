# Name: rtfdump
# Website: https://blog.didierstevens.com/2018/12/10/update-rtfdump-py-version-0-0-9/
# Description: Analyze a suspicious RTF file.
# Category: Analyze Documents: Microsoft Office
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: rtfdump.py

include:
  - remnux.packages.python3

remnux-scripts-rtfdump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/rtfdump_V0_0_10.zip
    - source: https://didierstevens.com/files/software/rtfdump_V0_0_10.zip
    - source_hash: sha256=750430C0DA0B9D25B0BBBB972F107D1459FEAF45A2D61EAB6C10E84CB8AA01F8
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-rtfdump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/rtfdump_V0_0_10
    - source: /usr/local/src/remnux/files/rtfdump_V0_0_10.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-rtfdump-source

remnux-scripts-rtfdump-binary:
  file.managed:
    - name: /usr/local/bin/rtfdump.py
    - source: /usr/local/src/remnux/rtfdump_V0_0_10/rtfdump.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-rtfdump-archive

remnux-scripts-rtfdump-shebang:
  file.replace:
    - name: /usr/local/bin/rtfdump.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/env python3'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-rtfdump-binary