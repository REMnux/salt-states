# Name: NoMoreXOR.py
# Website: https://github.com/hiddenillusion/NoMoreXOR
# Description: Help guess a file's 256-byte XOR by using frequency analysis.
# Category: Examine Static Properties: Deobfuscation
# Author: Glenn P. Edwards Jr.
# License: Free, unknown license
# Notes:

include:
  - remnux.python-packages.yara-python

remnux-scripts-nomorexor-source:
  file.managed:
  - name: /usr/local/bin/nomorexor.py
  - source: https://github.com/hiddenillusion/NoMoreXOR/raw/master/NoMoreXOR.py
  - source_hash: sha256=328719f484fac96ffe368fb375b82fea8ec5f341d656ac457fe4186dcc60ec3b
  - mode: 755
  - makedirs: false
  - require:
    - sls: remnux.python-packages.yara-python

