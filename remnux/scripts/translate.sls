# Name: translate.py
# Website: https://blog.didierstevens.com/programs/translate/
# Description: Translate bytes according to a Python expression.
# Category: Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

remnux-scripts-translate-source:
  file.managed:
    - name: /usr/local/src/remnux/files/translate_v2_5_9.zip
    - source: https://didierstevens.com/files/software/translate_v2_5_9.zip
    - source_hash: 3C469996F7014CC1BD5D4F02157B7D5803698D93018360904B79EA2A1601BD10
    - makedirs: True

remnux-scripts-translate-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/translate_v2_5_9
    - source: /usr/local/src/remnux/files/translate_v2_5_9.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-translate-source

remnux-scripts-translate-binary:
  file.managed:
    - name: /usr/local/bin/translate.py
    - source: /usr/local/src/remnux/translate_v2_5_9/translate.py
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
