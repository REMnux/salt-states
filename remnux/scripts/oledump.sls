include:
  - remnux.packages.python-yara
  - remnux.python-packages.olefile

remnux-scripts-oledump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/oledump_V0_0_28.zip
    - source: http://didierstevens.com/files/software/oledump_V0_0_28.zip
    - source_hash: sha256=58f44b68bc997c2a7f329978e13dc50e406ccccd2017c0375aa144712f029bfb
    - makedirs: True

remnux-scripts-oledump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/oledump-0.0.28
    - source: /usr/local/src/remnux/files/oledump_V0_0_28.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-oledump-source

remnux-scripts-oledump-binary:
  file.managed:
    - name: /usr/local/bin/oledump.py
    - source: /usr/local/src/remnux/oledump-0.0.28/oledump.py
    - mode: 755
    - require:
      - sls: remnux.packages.python-yara
      - sls: remnux.python-packages.olefile
    - watch:
      - archive: remnux-scripts-oledump-archive
