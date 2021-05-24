# Name: pefile
# Website: https://github.com/erocarrera/pefile
# Description: Python library for analyzing static properties of PE files.
# Category: Examine Static Properties: PE Files
# Author: Ero Carrera: http://blog.dkbza.org
# License: MIT License: https://github.com/erocarrera/pefile/blob/master/LICENSE
# Notes: https://github.com/erocarrera/pefile/blob/wiki/UsageExamples.md#introduction

include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip

remnux-python-packages-pefile:
  pip.installed:
    - name: pefile
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
