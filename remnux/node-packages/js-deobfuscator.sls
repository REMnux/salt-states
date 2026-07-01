# Name: JavaScript Deobfuscator
# Command: js-deobfuscator
# Website: https://github.com/ben-sb/javascript-deobfuscator
# Description: Deobfuscate JavaScript by removing common obfuscation techniques such as string arrays and proxy functions.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: ben-sb: https://github.com/ben-sb
# License: Apache License 2.0: https://github.com/ben-sb/javascript-deobfuscator/blob/master/LICENSE
# Notes: js-deobfuscator -i input.js -o output.js

include:
  - remnux.packages.nodejs

remnux-node-packages-js-deobfuscator:
  npm.installed:
    - name: js-deobfuscator
    - force_reinstall: true
    - require:
      - sls: remnux.packages.nodejs
