# Name: The Bitdefender Disassembler (bddisasm)
# Website: https://github.com/bitdefender/bddisasm
# Description: Disassemble 32 and 64-bit assembly instructions and emulate shellcode execution.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: Bitdefender's HVI Team: https://bitdefender.com
# License: Apache License 2.0: https://github.com/bitdefender/bddisasm/blob/master/LICENSE
# Notes: disasmtool

include:
  - remnux.repos.remnux
  
bddisasm:
  pkg.installed:
    - version: latest
    - upgrade: True
    - pkgrepo: remnux