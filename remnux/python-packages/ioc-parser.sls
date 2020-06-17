# Name: ioc_parser
# Website: https://github.com/buffer/ioc_parser
# Description: Tool to extract IOCs from security report PDFs
# Category: Examine file properties and contents: Define signatures
# Author: Armin Buescher
# License: https://github.com/buffer/ioc_parser/blob/master/LICENSE.txt
# Notes: ioc_parser

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.git

remnux-pip-ioc-parser:
  pip.installed:
    - name: git+https://github.com/buffer/ioc_parser
    - bin_env: '/usr/bin/python3'
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git
