# Name: ex_pe_xor.py
# Website: http://hooked-on-mnemonics.blogspot.com/2014/04/expexorpy.html
# Description: Search an XOR'ed file for indications of executable binaries.
# Category: Examine Static Properties: Deobfuscation
# Author: Alexander Hanel
# License: Free, unknown license
# Notes: 

include:
  - remnux.python3-packages.pefile

remnux-scripts-ex_pe_xor-source:
  file.managed:
    - name: /usr/local/bin/ex_pe_xor.py
    - source: https://github.com/digitalsleuth/ex_pe_xor/raw/master/ex_pe_xor.py
    - source_hash: sha256=0bd20c4dd899a457d3625cb37397c6341582a4d1e71b76bf05b62cd830e40570
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.python3-packages.pefile
