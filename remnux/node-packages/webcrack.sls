# Name: Webcrack
# Command: webcrack
# Website: https://github.com/j4k0xb/webcrack
# Description: Deobfuscate, unminify, and unpack bundled JavaScript, including scripts protected with obfuscator.io.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: j4k0xb: https://github.com/j4k0xb
# License: MIT License: https://github.com/j4k0xb/webcrack/blob/master/LICENSE
# Notes: webcrack input.js -o output-dir

include:
  - remnux.packages.build-essential
  - remnux.packages.nodejs
  - remnux.packages.python3

remnux-node-packages-webcrack:
  npm.installed:
    - name: webcrack
    - force_reinstall: true
    - require:
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.nodejs
      - sls: remnux.packages.python3
