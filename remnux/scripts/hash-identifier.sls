# Name: hash-identifier
# Website: https://github.com/blackploit/hash-identifier
# Description: Python script to identify different types of hashes
# Category: Examine file properties and contents: Hashes
# Author: Zion3R
# License: GNU GPL v3 (https://code.google.com/archive/p/hash-identifier/)
# Notes: hash-id.py

remnux-scripts-hash-identifier-source:
  file.managed:
    - name: /usr/local/bin/hash-id.py
    - source: https://github.com/blackploit/hash-identifier/raw/master/hash-id.py
    - source_hash: sha256=d523ad28ccb6fa9635b74255de7938b94e860c3a6fad1f94ebbc0000b56a64f2
    - mode: 755

remnux-scripts-hash-identifier-shebang:
  file.replace:
    - name: /usr/local/bin/hash-id.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - watch:
      - file: remnux-scripts-hash-identifier-source

remnux-scripts-hash-identifier-formatting:
  file.replace:
    - name: /usr/local/bin/hash-id.py
    - pattern: '\r'
    - repl: ''
    - watch:
      - file: remnux-scripts-hash-identifier-shebang
