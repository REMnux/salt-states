# Name: JS Beautifier
# Website: https://beautifier.io/
# Description: Reformat JavaScript scripts for easier analysis.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Einar Lielmanis, Liam Newman, and contributors
# License: MIT License: https://github.com/beautify-web/js-beautify/blob/master/LICENSE
# Notes: js-beautify

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-jsbeautifier:
  pip.installed:
    - name: jsbeautifier
    - upgrade: True
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
