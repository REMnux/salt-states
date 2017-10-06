include:
  - remnux.packages.python-yara

remnux-scripts-pdf-parser-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pdf-parser_V0_6_7.zip
    - source: http://didierstevens.com/files/software/pdf-parser_V0_6_7.zip
    - source_hash: sha256=ed863de952a5096ff4be0825110d2726ba1be75a7a6717af0e6a153b843e3b78
    - makedirs: True

remnux-scripts-pdf-parser-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pdf-parser-0.6.7
    - source: /usr/local/src/remnux/files/pdf-parser_V0_6_7.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-pdf-parser-source

remnux-scripts-pdf-parser-binary:
  file.managed:
    - name: /usr/local/bin/pdf-parser.py
    - source: /usr/local/src/remnux/pdf-parser-0.6.7/pdf-parser.py
    - mode: 755
    - require:
      - sls: remnux.packages.python-yara
    - watch:
      - archive: remnux-scripts-pdf-parser-archive
