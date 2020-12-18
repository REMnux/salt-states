# Name: officeparser
# Website: https://github.com/unixfreak0037/officeparser
# Description: Parse Microsoft Office OLE2 compound documents.
# Category: Analyze Documents: Microsoft Office
# Author: John William Davison
# License: MIT License: https://github.com/unixfreak0037/officeparser/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python3-pip
  - remnux.packages.python2

remnux-python3-packages-officeparser-remove:
  pip.removed:
    - name: officeparser
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip

remnux-scripts-officeparser:
  file.managed:
    - name: /usr/local/bin/officeparser.py
    - source: https://github.com/unixfreak0037/officeparser/raw/master/officeparser.py
    - source_hash: sha256=101ef6590e274061475f8f8f4335148af9ba5f09ff16fb775558e6438c3d68bb
    - makedirs: False
    - mode: 755
    - require:
      - sls: remnux.packages.python2

remnux-scripts-officeparser-shebang:
  file.replace:
    - name: /usr/local/bin/officeparser.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python2'
    - count: 1
    - require:
      - file: remnux-scripts-officeparser

