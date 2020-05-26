# Name: JS-Beautifier
# Website: https://beautifier.io/
# Description: Tool to reformat JavaScript scripts
# Category: Examine browser malware: JavaScript
# Author: Einar Lielmanis, Liam Newman, and contributors
# License: https://github.com/beautify-web/js-beautify/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip

remnux-jsbeautifier:
  pip.installed:
    - name: jsbeautifier
    - require:
      - sls: remnux.packages.python-pip
