# Name: JS Beautifier
# Website: https://beautifier.io/
# Description: Reformat JavaScript scripts for easier analysis.
# Category: Statically Analyze Code: Scripts
# Author: Einar Lielmanis, Liam Newman, and contributors
# License: MIT License: https://github.com/beautify-web/js-beautify/blob/master/LICENSE
# Notes: js-beautify

include:
  - remnux.python3-packages.pip

remnux-python3-packages-jsbeautifier:
  pip.installed:
    - name: jsbeautifier
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
