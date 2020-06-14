# Name: ibemu
# Website: https://github.com/buffer/libemu
# Description: x86 emulation and shellcode detection
# Category: Library
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
