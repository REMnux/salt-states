# Name: pefile
# Website: https://github.com/erocarrera/pefile
# Description: Python library for analyzing static properties of PE files.
# Category: Examine Static Properties: PE Files
# Author: Ero Carrera: http://blog.dkbza.org
# License: MIT License: https://github.com/erocarrera/pefile/blob/master/LICENSE
# Notes: https://github.com/erocarrera/pefile/blob/wiki/UsageExamples.md#introduction

include:
  - remnux.packages.python-pip

pefile:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
