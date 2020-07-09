# Name: shellcode2exe.bat
# Website: https://github.com/repnz/shellcode2exe
# Description: Convert 32 and 64-bit shellcode to a Windows executable file.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: Ori Damari: https://twitter.com/0xrepnz
# License: Free, unknown license
# Notes: 

include:
  - remnux.packages.git
  - remnux.packages.wine

remnux-tools-shellcode2exe-bat:
  git.cloned:
    - name: https://github.com/repnz/shellcode2exe.git
    - target: /usr/local/shellcode2exe-bat
    - user: root
    - branch: master
    - require:
      - sls: remnux.packages.wine

remnux-tools-shellcode2exe-bat-wrapper:
  file.managed:
    - name: /usr/local/bin/shellcode2exe.bat
    - mode: 755
    - watch:
      - git: remnux-tools-shellcode2exe-bat
    - contents:
      - '#!/bin/bash'
      - wine cmd /c "/usr/local/shellcode2exe-bat/shellcode2exe.bat ${*}"