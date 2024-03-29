# Name: ExtractScripts
# Website: https://blog.didierstevens.com/programs/extractscripts/
# Description: Extract scripts from HTML files.
# Category: Statically Analyze Code: Scripts
# Author: Didier Stevens
# License: Public Domain
# Notes: extractscripts.py

remnux-scripts-extractscripts-source:
  file.managed:
    - name: /usr/local/src/remnux/files/extractscripts.zip
    - source: https://www.didierstevens.com/files/software/extractscripts.zip
    - makedirs: True
    - skip_verify: True

remnux-scripts-extractscripts-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/extractscripts
    - source: /usr/local/src/remnux/files/extractscripts.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-extractscripts-source

remnux-scripts-extractscripts-binary:
  file.managed:
    - name: /usr/local/bin/extractscripts.py
    - source: /usr/local/src/remnux/extractscripts/extractscripts.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-extractscripts-archive

remnux-scripts-extractscripts-shebang:
  file.replace:
    - name: /usr/local/bin/extractscripts.py
    - pattern: '#!/usr/bin/python\n'
    - repl: '#!/usr/bin/env python2\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-extractscripts-binary
