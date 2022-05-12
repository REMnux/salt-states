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
    - source_hash: sha256=0da647b7f24ef3fa6eb66f0e23a508f01e78493a1084bf60b451940357756603
    - mode: 755
    - makedirs: false

remnux-pyinstaller-shebang:
  file.prepend:
    - name: /usr/local/bin/pyinstxtractor.py
    - text: '#!/usr/bin/env python3'
    - require:
      - file: remnux-pyinstaller-source
    - watch:
      - file: remnux-pyinstaller-source
