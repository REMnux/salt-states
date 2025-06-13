# Name: shcode2exe
# Website: https://github.com/accidentalrebel/shcode2exe
# Description: Convert 32 and 64-bit shellcode to a Windows executable file.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: Karlo Licudine: https://twitter.com/accidentalrebel
# License: GNU General Public License (GPL) v3.0: https://github.com/accidentalrebel/shcode2exe/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.nasm
  - remnux.packages.binutils
  - remnux.packages.python3

remnux-scripts-shcode2exe-source:
  file.managed:
    - name: /usr/local/bin/shcode2exe
    - source: https://github.com/accidentalrebel/shcode2exe/raw/master/shcode2exe.py
    - source_hash: sha256=4a1e9e34fe6f8926210872e842cee5dcbe1e401e25669c8d3746f12a82b9ecf3
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.nasm
      - sls: remnux.packages.binutils
      - sls: remnux.packages.python3