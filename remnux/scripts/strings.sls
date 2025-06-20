# Name: strings.py
# Website: https://blog.didierstevens.com/2018/12/09/release-strings-py/
# Description: Extract strings.
# Category: Analyze Documents: Microsoft Office, Examine Static Properties: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

include:
  - remnux.packages.python3

remnux-scripts-strings-source:
  file.managed:
    - name: /usr/local/src/remnux/files/strings_V0_0_11.zip
    - source: https://didierstevens.com/files/software/strings_V0_0_11.zip
    - source_hash: 08df9078b5ea41d50a3b06d2915b54246d02a932193d06c6130f9b9b8ad9f7a9
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-strings-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/strings_V0_0_11
    - source: /usr/local/src/remnux/files/strings_V0_0_11.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-strings-source

remnux-scripts-strings-shebang:
  file.replace:
    - name: /usr/local/src/remnux/strings_V0_0_11/strings.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - archive: remnux-scripts-strings-archive

remnux-scripts-strings-binary:
  file.managed:
    - name: /usr/local/bin/strings.py
    - source: /usr/local/src/remnux/strings_V0_0_11/strings.py
    - mode: 755
    - watch:
      - file: remnux-scripts-strings-shebang
