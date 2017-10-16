# Author: Didier Stevens
# Source: https://blog.didierstevens.com/programs/oledump-py/

include:
  - remnux.python-packages.yara-python
  - remnux.python-packages.olefile

remnux-scripts-oledump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/oledump_V0_0_29.zip
    - source: https://didierstevens.com/files/software/oledump_V0_0_29.zip
    - source_hash: sha256=e00567490a48a7749df07f0e7ecd8fd24b3c90dc52e18afe36253e0b37a543c5
    - makedirs: True

remnux-scripts-oledump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/oledump-0.0.29
    - source: /usr/local/src/remnux/files/oledump_V0_0_29.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-oledump-source

remnux-scripts-oledump-binary:
  file.managed:
    - name: /usr/local/bin/oledump.py
    - source: /usr/local/src/remnux/oledump-0.0.29/oledump.py
    - mode: 755
    - require:
      - sls: remnux.python-packages.yara-python
      - sls: remnux.python-packages.olefile
    - watch:
      - archive: remnux-scripts-oledump-archive
