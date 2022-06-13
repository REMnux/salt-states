# Name: PyInstaller Extractor
# Website: https://github.com/extremecoders-re/pyinstxtractor
# Description: Extract contents of a PyInstaller-generated PE files.
# Category: Statically Analyze Code: Python
# Author: extremecoders-re
# License: GNU General Public License (GPL) v3: https://github.com/extremecoders-re/pyinstxtractor/blob/master/LICENSE
# Notes: pyinstxtractor.py

include:
  - remnux.packages.python3

remnux-scripts-pyinstxtractor-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pyinstxtractor-2022.4.zip
    - source: https://github.com/extremecoders-re/pyinstxtractor/archive/refs/tags/2022.4.zip
    - source_hash: sha256=14ea2fdcf6f847d44abe1895457fad2622a1bfc75ae163a193eb9127841d52e4
    - makedirs: True

remnux-scripts-pyinstxtractor-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pyinstxtractor-2022.4
    - source: /usr/local/src/remnux/files/pyinstxtractor-2022.4.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-pyinstxtractor-source

remnux-scripts-pyinstxtractor-binary:
  file.managed:
    - name: /usr/local/bin/pyinstxtractor.py
    - source: /usr/local/src/remnux/pyinstxtractor-2022.4/pyinstxtractor-2022.4/pyinstxtractor.py
    - mode: 755
    - require:
      - sls: remnux.packages.python3
    - watch:
      - archive: remnux-scripts-pyinstxtractor-archive

remnux-scripts-pyinstxtractor-shebang:
  file.prepend:
    - name: /usr/local/bin/pyinstxtractor.py
    - text: '#!/usr/bin/env python3'
    - require:
      - file: remnux-scripts-pyinstxtractor-binary