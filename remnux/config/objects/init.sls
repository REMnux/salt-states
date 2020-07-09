# Name: objects.js
# Website: https://github.com/REMnux/salt-states/blob/master/remnux/config/objects/objects.js
# Description: Emulate common browser and PDF viewer objects, methods, and properties when deobfuscating JavaScript.
# Category: Dynamically Reverse-Engineer Code: Scripts, 
# Author: Lenny Zeltser
# License: Public Domain
# Notes: The file is in /usr/local/share/remnux

remnux-config-objects:
  file.managed:
    - name: /usr/local/share/remnux/objects.js
    - source: salt://remnux/config/objects/objects.js
    - makedirs: True