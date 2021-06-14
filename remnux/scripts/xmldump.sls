# Name: xmldump.py
# Website: https://blog.didierstevens.com/2017/12/18/new-tool-xmldump-py/
# Description: Extract contents of XML files, in particular OOXML-formatted Microsoft Office documents.
# Category: Analyze Documents: Microsoft Office
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

include:
  - remnux.packages.python3

remnux-scripts-xmldump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/xmldump_V0_0_6.zip
    - source: https://didierstevens.com/files/software/xmldump_V0_0_6.zip
    - source_hash: 1767C27D9907FDDF88015D938EFF47782C06547CEEF0493F67D85FF4A06656DA
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-xmldump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/xmldump_V0_0_6
    - source: /usr/local/src/remnux/files/xmldump_V0_0_6.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-xmldump-source

remnux-scripts-xmldump-shebang:
  file.replace:
    - name: /usr/local/src/remnux/xmldump_V0_0_6/xmldump.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - archive: remnux-scripts-xmldump-archive

remnux-scripts-xmldump-binary:
  file.managed:
    - name: /usr/local/bin/xmldump.py
    - source: /usr/local/src/remnux/xmldump_V0_0_6/xmldump.py
    - mode: 755
    - watch:
      - file: remnux-scripts-xmldump-shebang
