# Name: ex_pe_xor.py
# Website: http://hooked-on-mnemonics.blogspot.com/2014/04/expexorpy.html
# Description: Search an XOR'ed file for indications of executable binaries.
# Category: Examine Static Properties: Deobfuscation
# Author: Alexander Hanel
# License: Free, unknown license
# Notes: 

include:
  - remnux.python-packages.pefile

remnux-scripts-ex_pe_xor-source:
  file.managed:
    - name: /usr/local/bin/ex_pe_xor.py
    - source: https://github.com/digitalsleuth/ex_pe_xor/raw/master/ex_pe_xor.py
    - source_hash: sha256=be4abb09fd239c18f726ef17fed3df7c0458256ce1cd0f25ec989e304af2739e
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.python-packages.pefile
