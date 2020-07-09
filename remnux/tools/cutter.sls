# Name: Cutter
# Website: https://cutter.re
# Description: Reverse engineering platform powered by radare2
# Category: Statically Analyze Code: General
# Author: Unknown
# License: GNU General Public License (GPL) v3.0: https://github.com/radareorg/cutter/blob/master/COPYING
# Notes: 

remnux-tools-cutter-source:
  file.managed:
    - name: /usr/local/bin/cutter
    - source: https://github.com/radareorg/cutter/releases/download/v1.10.3/Cutter-v1.10.3-x64.Linux.AppImage
    - source_hash: 0e0fc13541ce5bd3730db3c6f870626424466dc20bc9030939b548edde459ff7
    - mode: 755

remnux-tools-cutter-icon:
  file.managed:
    - name: /usr/share/icons/cutter.svg
    - source: https://raw.githubusercontent.com/radareorg/cutter/v1.10.3/src/img/cutter.svg
    - source_hash: 4ad117f6d8fc9fffc1359d1eef7f3f1c68db0f74eebebc998fa47b89bab81832
    - mode: 644
    - watch:
      - file: remnux-tools-cutter-source