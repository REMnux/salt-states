# Name: ioc_parser
# Website: https://github.com/buffer/ioc_parser
# Description: Extract IOCs from security report PDFs.
# Category: Gather and Analyze Data
# Author: Armin Buescher
# License: MIT License: https://github.com/buffer/ioc_parser/blob/master/LICENSE.txt
# Notes:

include:
  - remnux.python3-packages.pip
  - remnux.packages.git

remnux-python3-packages-ioc-parser:
  pip.installed:
    - name: git+https://github.com/buffer/ioc_parser.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.git
