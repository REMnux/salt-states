# Name: ProcDOT
# Website: https://www.procdot.com
# Description: Visualize and examine the output of Process Monitor
# Category: Other tasks
# Author: Christian Wojner
# License: https://cert.at/media/files/downloads/software/procdot/files/license.txt
# Notes: procdot

remnux-tools-procdot-source:
  file.managed:
    - name: /usr/local/src/remnux/files/procdot_1_22_57_linux.zip
    - source: https://www.procdot.com/download/procdot/binaries/procdot_1_22_57_linux.zip
    - source_hash: 1a5821874e0cf73d717df064eac9f4d1f0bfbdeda99913f34b95a2fe62cef407
    - makedirs: True

remnux-tools-procdot-archive:
  archive.extracted:
    - name: /usr/local/procdot
    - source: /usr/local/src/remnux/files/procdot_1_22_57_linux.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-procdot-source

remnux-tools-procdot-binary-permissions:
  file.managed:
    - name: /usr/local/procdot/lin64/procdot
    - mode: 755
    - watch:
      - archive: remnux-tools-procdot-archive

remnux-tools-procmon2dot-binary-permissions:
  file.managed:
    - name: /usr/local/procdot/lin64/procmon2dot
    - mode: 755
    - watch:
      - archive: remnux-tools-procdot-archive

/usr/local/bin/procdot:
  file.symlink:
    - target: /usr/local/procdot/lin64/procdot
    - watch:
      - file: remnux-tools-procdot-binary-permissions