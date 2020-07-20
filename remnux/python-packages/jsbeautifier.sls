# Name: JS Beautifier
# Website: https://beautifier.io/
# Description: Reformat JavaScript scripts for easier analysis.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Einar Lielmanis, Liam Newman, and contributors
# License: MIT License: https://github.com/beautify-web/js-beautify/blob/master/LICENSE
# Notes: js-beautify

include:
  - remnux.packages.python-pip

remnux-jsbeautifier:
  pip.installed:
    - name: jsbeautifier
    - require:
      - sls: remnux.packages.python-pip
