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
    - source_hash: 4b9ffce3bfb53013b860cbf2af97b847cb3f259d5bb8633106caa94ac006a483
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
