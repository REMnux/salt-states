# Name: shellcode2exe.py
# Website: https://github.com/MarioVilas/shellcode_tools
# Description: Shellcode to executable converter
# Category: Examine document files: Shellcode
# Author: Mario Vilas
# License: https://github.com/MarioVilas/shellcode_tools/blob/master/shellcode2exe.py#L23
# Notes: 

include:
  - remnux.python-packages.inlineegg

remnux-scripts-shellcode2exe-source:
  file.managed:
    - name: /usr/local/bin/shellcode2exe.py
    - source: https://raw.githubusercontent.com/MarioVilas/shellcode_tools/master/shellcode2exe.py
    - source_hash: sha256=2cf1d7f06123b61bb6c92e5062c02ee9932ced6b5df70817468eee7ba14978e8
    - mode: 755
    - require:
      - sls: remnux.python-packages.inlineegg


