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
    - name: /usr/local/src/remnux/files/xmldump_V0_0_7_pre.zip
    - source: https://github.com/REMnux/distro/raw/master/files/xmldump_V0_0_7_pre.zip
    - source_hash: fe1766afd89dcfcf7005ad17e0833a9708beb80bd18afad954c7a4643132bc09
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-xmldump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/xmldump_V0_0_7_pre
    - source: /usr/local/src/remnux/files/xmldump_V0_0_7_pre.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-xmldump-source

remnux-scripts-xmldump-shebang:
  file.replace:
    - name: /usr/local/src/remnux/xmldump_V0_0_7_pre/xmldump.py
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
    - source: /usr/local/src/remnux/xmldump_V0_0_7_pre/xmldump.py
    - mode: 755
    - watch:
      - file: remnux-scripts-xmldump-shebang
