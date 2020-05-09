# Name: Cutter
# Website: https://cutter.re
# Description: Reverse engineering platform powered by radare2
# Category: Static Analysis
# Author: Radare
# License: https://github.com/radareorg/cutter/blob/master/COPYING
# Notes: 

remnux-tools-cutter-source:
  file.managed:
    - name: /usr/local/bin/cutter
    - source: https://github.com/radareorg/cutter/releases/download/v1.10.3/Cutter-v1.10.3-x64.Linux.AppImage
    - source_hash: 0e0fc13541ce5bd3730db3c6f870626424466dc20bc9030939b548edde459ff7
    - mode: 755
