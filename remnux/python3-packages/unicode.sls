# Name: unicode
# Website: https://github.com/garabik/unicode
# Description: Display Unicode character properties.
# Category: Examine Static Properties: Deobfuscation
# Author: Radovan Garabik
# License: GNU General Public License (GPL) v3: https://github.com/garabik/unicode/blob/master/COPYING
# Notes: 

include:
  - remnux.python3-packages.pip

remnux-python3-packages-unicode:
  pip.installed:
    - name: unicode
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip

