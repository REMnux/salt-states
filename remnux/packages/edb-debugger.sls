# Name: Evan Teran: edb
# Website: https://github.com/eteran/edb-debugger
# Description: An AArch32/x86/x86-64 debugger, well suited for debugging ELF files.
# Category: Investigate Linux Malware
# Author: Evan Teran: http://codef00.com/about
# License: https://github.com/eteran/edb-debugger/blob/master/COPYING
# Notes: 

include:
  - remnux.repos.remnux
  
edb-debugger:
  pkg.installed:
    - pkgrepo: remnux