# Name: libemu
# Website: https://github.com/buffer/libemu
# Description: A library for x86 code emulation and shellcode detection
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: https://github.com/buffer/libemu/blob/master/AUTHORS
# License: Free, unknown license
# Notes: 

include:
  - remnux.repos.remnux
  
libemu:
  pkg.installed:
    - pkgrepo: remnux

libemu-dev:
  pkg.installed:
    - pkgrepo: remnux

remnux-packages-libemu-ldconfig:
  cmd.run:
    - name: ldconfig
    - watch:
      - pkg: libemu
