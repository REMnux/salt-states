# Name: numbers-to-string.py
# Website: https://blog.didierstevens.com/2020/12/12/update-numbers-to-string-py-version-0-0-11/
# Description: Convert decimal numbers to strings.
# Category: Examine Static Properties: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

include:
  - remnux.packages.python3

remnux-scripts-numbers-to-string-source:
  file.managed:
    - name: /usr/local/src/remnux/files/numbers-to-string_v0_0_11.zip
    - source: https://didierstevens.com/files/software/numbers-to-string_v0_0_11.zip
    - source_hash: 0E748886E97E351B64BD288D3EC6F322FFB7B1AA89410897E6B2BA03701EA852
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-numbers-to-string-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/numbers-to-string_v0_0_11
    - source: /usr/local/src/remnux/files/numbers-to-string_v0_0_11.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-numbers-to-string-source

remnux-scripts-numbers-to-string-shebang:
  file.replace:
    - name: /usr/local/src/remnux/numbers-to-string_v0_0_11/numbers-to-string.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - archive: remnux-scripts-numbers-to-string-archive

remnux-scripts-numbers-to-string-binary:
  file.managed:
    - name: /usr/local/bin/numbers-to-string.py
    - source: /usr/local/src/remnux/numbers-to-string_v0_0_11/numbers-to-string.py
    - mode: 755
    - watch:
      - file: remnux-scripts-numbers-to-string-shebang
