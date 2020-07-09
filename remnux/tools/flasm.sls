# Name: Flasm
# Website: http://www.nowrap.de/flasm.html
# Description: Extract and disassemble ActionScript from Flash (SWF) files.
# Category: Statically Analyze Code: Flash
# Author: Igor Kogan, Wang Zhen
# License: Freeware with some restrictions
# Notes: 

include:
  - remnux.packages.i386-architecture

remnux-tools-flasm-source:
  file.managed:
    - name: /usr/local/src/remnux/files/flasm16linux.tgz
    - source: https://www.nowrap.de/download/flasm16linux.tgz
    - source_hash: 88f16edcdee60773828107e6af16265a21bd577cf6acbf374c7864d2b58d43cb
    - makedirs: True
    - require:
      - sls: remnux.packages.i386-architecture

remnux-tools-flasm-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/flasm16linux
    - source: /usr/local/src/remnux/files/flasm16linux.tgz
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-flasm-source

remnux-tools-flasm-binary:
  file.managed:
    - name: /usr/local/bin/flasm
    - source: /usr/local/src/remnux/flasm16linux/flasm
    - mode: 755
    - watch:
      - archive: remnux-tools-flasm-archive