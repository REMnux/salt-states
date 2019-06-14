# Author: Didier Stevens
# Source: https://blog.didierstevens.com/programs/oledump-py/

include:
  - remnux.python-packages.yara-python
  - remnux.python-packages.olefile

remnux-scripts-oledump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/oledump_V0_0_42.zip
    - source: https://didierstevens.com/files/software/oledump_V0_0_42.zip
    - source_hash: sha256=14A1FDA4AB57B09729AEB2697818782FAE498369A760FEC8AEE5CFB0A0E9D126
    - makedirs: True

remnux-scripts-oledump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/oledump_V0_0_42
    - source: /usr/local/src/remnux/files/oledump_V0_0_42.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-oledump-source

remnux-scripts-oledump-binary:
  file.managed:
    - name: /usr/local/bin/oledump.py
    - source: /usr/local/src/remnux/oledump_V0_0_42/oledump.py
    - mode: 755
    - require:
      - sls: remnux.python-packages.yara-python
      - sls: remnux.python-packages.olefile
    - watch:
      - archive: remnux-scripts-oledump-archive
