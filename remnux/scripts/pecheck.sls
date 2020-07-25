# Name: pecheck.py
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
    - source_hash: sha256=b0c2e7920a2948736a93d4d306f6feea201bec6108838d572c3e846d659f80ed
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