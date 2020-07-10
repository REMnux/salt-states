# Name: oledump
# Website: https://blog.didierstevens.com/programs/oledump-py/
# Description: Analyze OLE2 Structured Storage files
# Category: Analyze Documents: Microsoft Office
# Author: Didier Stevens 
# License: Public Domain
# Notes: 

include:
  - remnux.python-packages.yara-python
  - remnux.python-packages.olefile

remnux-scripts-oledump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/oledump_V0_0_50.zip
    - source: https://didierstevens.com/files/software/oledump_V0_0_50.zip
    - source_hash: sha256=870167AE5576B169EB52572788D04F1FFCEC5C8AFDEBCC59FE3B8B01CBDE6CD9
    - makedirs: True

remnux-scripts-oledump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/oledump_V0_0_50
    - source: /usr/local/src/remnux/files/oledump_V0_0_50.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-oledump-source

remnux-scripts-oledump-binary:
  file.managed:
    - name: /usr/local/bin/oledump.py
    - source: /usr/local/src/remnux/oledump_V0_0_50/oledump.py
    - mode: 755
    - require:
      - sls: remnux.python-packages.yara-python
      - sls: remnux.python-packages.olefile
    - watch:
      - archive: remnux-scripts-oledump-archive
