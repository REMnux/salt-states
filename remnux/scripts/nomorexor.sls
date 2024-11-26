# Name: NoMoreXOR.py
# Website: https://github.com/digitalsleuth/NoMoreXOR
# Description: Help guess a file's 256-byte XOR by using frequency analysis.
# Category: Examine Static Properties: Deobfuscation
# Author: Glenn P. Edwards Jr.
# License: Free, unknown license
# Notes:

include:
  - remnux.python3-packages.yara-python3

remnux-scripts-nomorexor-source:
  file.managed:
  - name: /usr/local/bin/nomorexor.py
  - source: https://github.com/digitalsleuth/NoMoreXOR/raw/master/nomorexor.py
  - source_hash: sha256=597fccfa5983f50bd50539e1d451e32144e4adf9027a577125263d4e28b402c5
  - mode: 755
  - makedirs: false
  - require:
    - sls: remnux.python3-packages.yara-python3
