# Name: cut-bytes.py
# Website: https://blog.didierstevens.com/2015/10/14/cut-bytes-py/
# Description: Cut out a part of a data stream.
# Category: Dynamically Reverse-Engineer Code: Shellcode, Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

remnux-scripts-cut-bytes-source:
  file.managed:
    - name: /usr/local/src/remnux/files/cut-bytes_V0_0_13.zip
    - source: http://didierstevens.com/files/software/cut-bytes_V0_0_13.zip
    - source_hash: 2276257173FD1DF65338CFA53DDE5522ED8A7D7E94BCC302117F535F584F14CF
    - makedirs: True

remnux-scripts-cut-bytes-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/cut-bytes_V0_0_13
    - source: /usr/local/src/remnux/files/cut-bytes_V0_0_13.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-cut-bytes-source

remnux-scripts-cut-bytes-formatting:
  file.replace:
    - name: /usr/local/src/remnux/cut-bytes_V0_0_13/cut-bytes.py
    - pattern: '\r'
    - repl: ''
    - require:
      - archive: remnux-scripts-cut-bytes-archive

remnux-scripts-cut-bytes-binary:
  file.managed:
    - name: /usr/local/bin/cut-bytes.py
    - source: /usr/local/src/remnux/cut-bytes_V0_0_13/cut-bytes.py
    - mode: 755
    - watch:
      - file: remnux-scripts-cut-bytes-formatting

remnux-scripts-cut-bytes-shebang:
  file.replace:
    - name: /usr/local/bin/cut-bytes.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-cut-bytes-binary
