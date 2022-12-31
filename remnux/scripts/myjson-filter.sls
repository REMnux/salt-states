# Name: myjson-filter.py
# Website: https://blog.didierstevens.com/2022/04/09/new-tool-myjson-filter-py/
# Description: Filter data formatted using the JSON format used by Didier Stevens' tools.
# Category: General Utilities
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

include:
  - remnux.packages.python3

remnux-scripts-myjson-filter-source:
  file.managed:
    - name: /usr/local/src/remnux/files/myjson-filter_V0_0_3.zip
    - source: https://didierstevens.com/files/software/myjson-filter_V0_0_3.zip
    - source_hash: AB73314ACCD65EC765D6DDA629AF273FF882D293F11F6A2EA8FC633B019E5836
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-myjson-filter-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/myjson-filter_V0_0_3
    - source: /usr/local/src/remnux/files/myjson-filter_V0_0_3.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-myjson-filter-source

remnux-scripts-myjson-filter-shebang:
  file.replace:
    - name: /usr/local/src/remnux/myjson-filter_V0_0_3/myjson-filter.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - archive: remnux-scripts-myjson-filter-archive

remnux-scripts-myjson-filter-binary:
  file.managed:
    - name: /usr/local/bin/myjson-filter.py
    - source: /usr/local/src/remnux/myjson-filter_V0_0_3/myjson-filter.py
    - mode: 755
    - watch:
      - file: remnux-scripts-myjson-filter-shebang