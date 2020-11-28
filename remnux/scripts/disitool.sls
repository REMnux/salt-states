# Name: disitool
# Website: https://blog.didierstevens.com/programs/disitool/
# Description: Manipulate embedded digital signatures.
# Category: Examine Static Properties: General
# Author: Didier Stevens
# License: Public Domain
# Notes: disitool.py

include:
  - remnux.python3-packages.pefile

remnux-scripts-disitool-source:
  file.managed:
    - name: /usr/local/src/remnux/files/disitool_v0_4.zip
    - source: https://didierstevens.com/files/software/disitool_v0_4.zip
    - source_hash: sha256=51EBFB0759FEEA69FFFB643659FD74DC5043338719A91CE36E427D175196661A
    - makedirs: True
    - require:
      - sls: remnux.python3-packages.pefile

remnux-scripts-disitool-archive:
  archive.extracted:
    - name: /usr/local/bin/
    - source: /usr/local/src/remnux/files/disitool_v0_4.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-disitool-source

/usr/local/bin/disitool.py:
  file.managed:
    - mode: 755
    - watch:
      - archive: remnux-scripts-disitool-archive

remnux-scripts-disitool-shebang:
  file.replace:
    - name: /usr/local/bin/disitool.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/python3'
    - backup: false
    - count: 1
    - watch:
      - archive: remnux-scripts-disitool-archive
