# Name: radare2
# Website: https://www.radare.org/n/radare2.html
# Description: Examine binary files, including disassembling and debugging.
# Category: Dynamically Reverse-Engineer Code: General
# Author: https://github.com/radareorg/radare2/blob/master/AUTHORS.md
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/radareorg/radare2/blob/master/COPYING
# Notes: r2, rasm2, rabin2, rahash2, rafind2

include:
  - remnux.packages.git

remnux-radare2-source:
  file.managed:
    - name: /usr/local/src/radare2_4.3.1_amd64.deb
    - source: http://radare.mikelloc.com/get/4.3.1/radare2_4.3.1_amd64.deb
    - source_hash: sha256=d72170c5dcfdc10eed604f9e33b2868107aee6db564152eb63cab78b1d066aa7

remnux-radare2:
  pkg.installed:
    - sources:
      - radare2: /usr/local/src/radare2_4.3.1_amd64.deb
    - watch:
      - file: remnux-radare2-source
    - require:
      - pkg: git

remnux-radare2-init:
  cmd.wait:
    - name: r2pm init
    - watch:
      - pkg: remnux-radare2

remnux-radare2-update:
  cmd.wait:
    - name: r2pm update
    - watch:
      - cmd: remnux-radare2-init