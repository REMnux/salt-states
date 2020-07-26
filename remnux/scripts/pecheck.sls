# Name: pecheck
# Website: https://blog.didierstevens.com/2020/03/15/pecheck-py-version-0-7-10/
# Description: Analyze static properties of PE files.
# Category: Examine Static Properties: PE Files
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: 

include:
  - remnux.python-packages.pefile

remnux-scripts-pecheck-source:
  file.managed:
    - name: /usr/local/bin/pecheck.py
    - source: https://raw.githubusercontent.com/DidierStevens/DidierStevensSuite/master/pecheck.py
    - source_hash: sha256=e0fa431af646b204bf8c55d8fc5198232a68b43d4c16bd2245047a56a7776f82
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.python-packages.pefile

remnux-scripts-pecheck-shebang:
  file.replace:
    - name: /usr/local/bin/pecheck.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - file: remnux-scripts-pecheck-source