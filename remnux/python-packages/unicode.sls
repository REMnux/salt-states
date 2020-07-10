# Name: unicode
# Website: https://github.com/garabik/unicode
# Description: Display Unicode character properties.
# Category: Examine Static Properties: Deobfuscation
# Author: Radovan Garabik
# License: GNU General Public License (GPL) v3: https://github.com/garabik/unicode/blob/master/COPYING
# Notes: 

include:
  - remnux.packages.python3-pip
  - remnux.packages.python-pip

remnux-pip-unicode:
  pip.installed:
    - name: unicode
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python-pip

