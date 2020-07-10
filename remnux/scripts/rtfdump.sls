# Name: rtfdump
# Website: https://blog.didierstevens.com/2018/12/10/update-rtfdump-py-version-0-0-9/
# Description: Analyze a suspicious RTF file.
# Category: Analyze Documents: Microsoft Office
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: rtfdump.py

remnux-scripts-rtfdump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/rtfdump_V0_0_9.zip
    - source: https://didierstevens.com/files/software/rtfdump_V0_0_9.zip
    - source_hash: sha256=3f6410ac7880116cdde4480367d3f5aa534cca3047b75fea0f4ba1f5eaa97b07
    - makedirs: True

remnux-scripts-rtfdump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/rtfdump_V0_0_9
    - source: /usr/local/src/remnux/files/rtfdump_V0_0_9.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-rtfdump-source

remnux-scripts-rtfdump-binary:
  file.managed:
    - name: /usr/local/bin/rtfdump.py
    - source: /usr/local/src/remnux/rtfdump_V0_0_9/rtfdump.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-rtfdump-archive