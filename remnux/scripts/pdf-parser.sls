# Name: pdf-parser.py
# Website: https://blog.didierstevens.com/programs/pdf-tools/
# Description: Examine elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Didier Stevens 
# License: Public Domain
# Notes:

include:
  - remnux.python-packages.yara-python

remnux-scripts-pdf-parser-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pdf-parser_V0_7_4.zip
    - source: https://didierstevens.com/files/software/pdf-parser_V0_7_4.zip
    - source_hash: sha256=FC318841952190D51EB70DAFB0666D7D19652C8839829CC0C3871BBF7E155B6A
    - makedirs: True

remnux-scripts-pdf-parser-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pdf-parser_V0_7_4
    - source: /usr/local/src/remnux/files/pdf-parser_V0_7_4.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-pdf-parser-source

remnux-scripts-pdf-parser-binary:
  file.managed:
    - name: /usr/local/bin/pdf-parser.py
    - source: /usr/local/src/remnux/pdf-parser_V0_7_4/pdf-parser.py
    - mode: 755
    - require:
      - sls: remnux.python-packages.yara-python
    - watch:
      - archive: remnux-scripts-pdf-parser-archive

remnux-scripts-pdf-parser-shebang:
  file.replace:
    - name: /usr/local/bin/pdf-parser.py
    - pattern: '#!/usr/bin/python\n'
    - repl: '#!/usr/bin/env python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-pdf-parser-binary

remnux-scripts-pdf-parser-python-version:
  file.replace:
    - name: /usr/local/bin/pdf-parser.py
    - pattern: '__maximum_python_version__ = (3, 7, 5)\n'
    - repl: '__maximum_python_version__ = (3, 8, 5)\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-pdf-parser-shebang