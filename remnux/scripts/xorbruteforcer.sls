# Name: xorBruteForcer.py
# Website: https://eternal-todo.com/category/bruteforcer
# Description: Bruteforce an XOR-encoded file.
# Category: Examine Static Properties: Deobfuscation
# Author: Jose Miguel Esparza
# License: Free, unknown license
# Notes: Not added as it is still python 2

remnux-scripts-xorbruteforcer-source:
  file.managed:
    - name: /usr/local/bin/xorbruteforcer.py
    - source: https://github.com/jesparza/scripts/raw/master/xorBruteForcer.py
    - source_hash: sha256=bec8155440df3e6087babe9bfc457af31f9886262c239aa61bda30b9af22b6b9
    - mode: 755
    - makedirs: false

remnux-scripts-xorbruteforcer-shebang:
  file.replace:
    - name: /usr/local/bin/xorbruteforcer.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python2\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-xorbruteforcer-source
