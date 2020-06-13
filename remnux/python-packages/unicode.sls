# Name: unicode
# Website: https://github.com/garabik/unicode
# Description: Display unicode character properties
# Category: Artifact Extraction and Decoding: Extract Strings
# Author: Radovan Garabik
# License: https://github.com/garabik/unicode/blob/master/COPYING
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

