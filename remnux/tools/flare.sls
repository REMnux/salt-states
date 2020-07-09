# Name: Flare
# Website: http://www.nowrap.de/flare.html
# Description: Extract and decompile ActionScript from Flash (SWF) files.
# Category: Statically Analyze Code: Flash
# Author: Igor Kogan
# License: Freeware with some restrictions
# Notes: 

remnux-tools-flare-source:
  file.managed:
    - name: /usr/local/src/remnux/files/flare06linux64.tgz
    - source: https://www.nowrap.de/download/flare06linux64.tgz
    - source_hash: c83ecd7836298e4f6a3258c2a8428f78d91ef58f142b0251f013a2746ede50e6
    - makedirs: True

remnux-tools-flare-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/flare06linux64
    - source: /usr/local/src/remnux/files/flare06linux64.tgz
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-flare-source

remnux-tools-flare-binary:
  file.managed:
    - name: /usr/local/bin/flare
    - source: /usr/local/src/remnux/flare06linux64/flare
    - mode: 755
    - watch:
      - archive: remnux-tools-flare-archive