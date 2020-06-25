# Name: pdf-parser
# Website: https://blog.didierstevens.com/programs/pdf-tools/
# Description: Tool to identify fundamental elements used in a given PDF file
# Category: Examine document files: PDF
# Author: Didier Stevens 
# License: Public Domain
# Notes:

include:
  - remnux.packages.python-yara

remnux-scripts-pdf-parser-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pdf-parser_V0_7_1.zip
    - source: https://didierstevens.com/files/software/pdf-parser_V0_7_1.zip
    - source_hash: sha256=D2C8E0599A84127C36656AA2600F9668A3CB12EF306D28752D6D8AC436A89D1A
    - makedirs: True

remnux-scripts-pdf-parser-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pdf-parser_V0_7_1
    - source: /usr/local/src/remnux/files/pdf-parser_V0_7_1.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-pdf-parser-source

remnux-scripts-pdf-parser-binary:
  file.managed:
    - name: /usr/local/bin/pdf-parser.py
    - source: /usr/local/src/remnux/pdf-parser_V0_7_1/pdf-parser.py
    - mode: 755
    - require:
      - sls: remnux.packages.python-yara
    - watch:
      - archive: remnux-scripts-pdf-parser-archive
