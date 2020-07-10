# Name: pyelftools
# Website: https://github.com/eliben/pyelftools
# Description: Python library for parsing and analyzing ELF files and DWARF debugging information. 
# Category: Examine Static Properties: ELF Files
# Author: Eli Bendersky
# License: Public Domain: https://github.com/eliben/pyelftools/blob/master/LICENSE
# Notes: readelf.py

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-pyelftools:
  pip.installed:
    - name: pyelftools
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip

remnux-python-packages-pyelftools-shebang:
  file.replace:
    - name: /usr/local/bin/readelf.py
    - pattern: '#!/usr/bin/python'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-pyelftools
