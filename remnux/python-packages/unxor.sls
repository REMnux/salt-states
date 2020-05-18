# Name: unXOR
# Website: https://github.com/tomchop/unxor/
# Description: Python 2 script to deobfuscate XOR'd files
# Category: Artifact Extraction and Decoding: Deobfuscate
# Author: Thomas Chopitea
# License: https://github.com/tomchop/unxor/blob/master/LICENSE
# Notes: 

remnux-scripts-unxor-source:
  file.managed:
    - name: /usr/local/bin/unxor.py
    - source: https://raw.githubusercontent.com/tomchop/unxor/master/pyunxor/unxor.py
    - source_hash: sha256=ee032801db92f42ee62fb4cc28d6c333ae6badfd307eec222ff2b8600035d75b
    - mode: 755
