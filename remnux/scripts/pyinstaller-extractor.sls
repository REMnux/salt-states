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
    - source_hash: sha256=f0710aa500d7100f0c6cd0d2c53328022108bfd88f91098616bdff32fb15d6e7
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
