# Name: SSView
# Website: https://www.mitec.cz/ssv.html
# Description: Analyze OLE2 Structured Storage files
# Category: Analyze Documents: Microsoft Office
# Author: Michal Mutl
# License: Free to use for private, educational and non-commercial purposes.
# Notes: ssview

include:
  - remnux.packages.wine

remnux-tools-ssview-source:
  file.managed:
    - name: /usr/local/src/remnux/files/SSView.zip
    - source: https://www.mitec.cz/Downloads/SSView.zip
    - source_hash: 4d2b244fff9524c26fa2d52cce763578a0a30e4ef7020435e744d3e5f4ddb44c
    - makedirs: True
    - require:
      - sls: remnux.packages.wine

remnux-tools-ssview-archive:
  archive.extracted:
    - name: /usr/local/ssview
    - source: /usr/local/src/remnux/files/SSView.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-ssview-source

remnux-tools-ssview-wrapper:
  file.managed:
    - name: /usr/local/bin/ssview
    - mode: 755
    - watch:
      - archive: remnux-tools-ssview-archive
    - contents:
      - '#!/bin/bash'
      - wine /usr/local/ssview/SSView.exe ${*}