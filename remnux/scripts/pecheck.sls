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
    - source_hash: sha256=625ca103ce368a57e58091b1f38430b7ffd72bda27c4c449ac3cb4a7bbbe6533
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