# Name: PyInstaller Extractor
# Website: https://github.com/extremecoders-re/pyinstxtractor
# Description: Extract contents of a PyInstaller-generated PE files.
# Category: Statically Analyze Code: Python
# Author: extremecoders-re
# License: GNU General Public License (GPL) v3: https://github.com/extremecoders-re/pyinstxtractor/blob/master/LICENSE
# Notes: pyinstxtractor.py

remnux-pyinstaller-source:
  file.managed:
    - name: /usr/local/bin/pyinstxtractor.py
    - source: https://github.com/extremecoders-re/pyinstxtractor/raw/master/pyinstxtractor.py
    - source_hash: sha256=1494b4979ca8facadf2ac3b1a44de55793df98688b6a8d94d75656fc5939221b
    - mode: 755
    - makedirs: false

remnux-pyinstaller-shebang:
  file.replace:
    - name: /usr/local/bin/pyinstxtractor.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: True
    - count: 1
    - require:
      - file: remnux-pyinstaller-source
    - watch:
      - file: remnux-pyinstaller-source
