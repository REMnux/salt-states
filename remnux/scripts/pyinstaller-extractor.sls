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
    - source_hash: sha256=8f4ff4e20f88c8f31ed378cccfbbdac454b45411136072947f28f63bd5403a06
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
