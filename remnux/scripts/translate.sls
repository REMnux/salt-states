# Name: translate.py
# Website: https://blog.didierstevens.com/programs/translate/
# Description: Translate bytes according to a Python expression.
# Category: Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

include:
  - remnux.packages.python3

remnux-scripts-translate-source:
  file.managed:
    - name: /usr/local/src/remnux/files/translate_v2_5_12.zip
    - source: https://didierstevens.com/files/software/translate_v2_5_12.zip
    - source_hash: 899109A9D787D6781AEB0569330A01709063BB3FD58F4AED068A57951B230F88
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-translate-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/translate_v2_5_12
    - source: /usr/local/src/remnux/files/translate_v2_5_12.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-translate-source

remnux-scripts-translate-binary:
  file.managed:
    - name: /usr/local/bin/translate.py
    - source: /usr/local/src/remnux/translate_v2_5_12/translate.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-translate-archive

remnux-scripts-translate-shebang:
  file.replace:
    - name: /usr/local/bin/translate.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - count: 1
    - require:
      - file: remnux-scripts-translate-binary
