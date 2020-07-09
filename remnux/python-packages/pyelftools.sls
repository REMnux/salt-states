# Name: pyelftools
# Website: https://github.com/eliben/pyelftools
# Description: Python library for parsing and analyzing ELF files and DWARF debugging information. 
# Category: Examine Static Properties: ELF Files
# Author: Eli Bendersky
# License: Public Domain: https://github.com/eliben/pyelftools/blob/master/LICENSE
# Notes: readelf.py

include:
  - remnux.packages.python-pip

pyelftools:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
