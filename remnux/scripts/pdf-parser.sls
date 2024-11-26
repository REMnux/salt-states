# Name: pdf-parser.py
# Website: https://blog.didierstevens.com/programs/pdf-tools/
# Description: Examine elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Didier Stevens 
# License: Public Domain
# Notes:

{% set version = '0_7_10' %}
{% set hash = '17f9ea0b4cadf0143aa52e1406eec7769da1b860375440d8492adc113300cdfd' %}
include:
  - remnux.python3-packages.yara-python3

remnux-scripts-pdf-parser-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pdf-parser_V{{ version }}.zip
    - source: https://didierstevens.com/files/software/pdf-parser_V{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-scripts-pdf-parser-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pdf-parser_V{{ version }}
    - source: /usr/local/src/remnux/files/pdf-parser_V{{ version }}.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-pdf-parser-source

remnux-scripts-pdf-parser-binary:
  file.managed:
    - name: /usr/local/bin/pdf-parser.py
    - source: /usr/local/src/remnux/pdf-parser_V{{ version }}/pdf-parser.py
    - mode: 755
    - require:
      - sls: remnux.python3-packages.yara-python3
    - watch:
      - archive: remnux-scripts-pdf-parser-archive

remnux-scripts-pdf-parser-shebang:
  file.replace:
    - name: /usr/local/bin/pdf-parser.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-pdf-parser-binary
