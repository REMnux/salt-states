# Name: texteditor.py
# Website: https://blog.didierstevens.com/2021/07/05/new-tool-texteditor-py/
# Description: Edit text files from the command line using search-and-replace commands.
# Category: General Utilities
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: 

include:
  - remnux.packages.python3

remnux-scripts-texteditor:
  file.managed:
    - name: /usr/local/bin/texteditor.py
    - source: https://github.com/DidierStevens/DidierStevensSuite/raw/master/texteditor.py
    - source_hash: sha256=c5d1578711cbb6f448f50d1e8e78aeff65e6161d0dcb7b8f2b19d7a85607db51
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.python3

remnux-scripts-texteditor-shebang:
  file.replace:
    - name: /usr/local/bin/texteditor.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - file: remnux-scripts-texteditor