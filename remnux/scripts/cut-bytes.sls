# Name: cut-bytes.py
# Website: https://blog.didierstevens.com/2015/10/14/cut-bytes-py/
# Description: Cut out a part of a data stream.
# Category: Dynamically Reverse-Engineer Code: Shellcode, Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

remnux-scripts-cut-bytes-source:
  file.managed:
    - name: /usr/local/src/remnux/files/cut-bytes_V0_0_1.zip
    - source: https://didierstevens.com/files/software/cut-bytes_V0_0_1.zip
    - source_hash: E99BC09DA0F1310085ED1520D52FB188D06456D030BD05A941FCE2B5FE21A661
    - makedirs: True

remnux-scripts-cut-bytes-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/cut-bytes_V0_0_1
    - source: /usr/local/src/remnux/files/cut-bytes_V0_0_1.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-cut-bytes-source

remnux-scripts-cut-bytes-formatting:
  file.replace:
    - name: /usr/local/src/remnux/cut-bytes_V0_0_1/cut-bytes.py
    - pattern: '\r'
    - repl: ''
    - require:
      - archive: remnux-scripts-cut-bytes-archive

remnux-scripts-cut-bytes-binary:
  file.managed:
    - name: /usr/local/bin/cut-bytes.py
    - source: /usr/local/src/remnux/cut-bytes_V0_0_1/cut-bytes.py
    - mode: 755
    - watch:
      - file: remnux-scripts-cut-bytes-formatting
