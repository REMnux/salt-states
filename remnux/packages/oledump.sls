# Name: oledump
# Website: https://blog.didierstevens.com/programs/oledump-py/
# Description: Analyze OLE2 Structured Storage files.
# Category: Analyze Documents: Microsoft Office
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: oledump.py

include:
  - remnux.python-packages.yara-python3
  - remnux.python-packages.olefile
  - remnux.python-packages.pyzipper
  - remnux.repos.remnux

remnux-packages-oledump:
  pkg.installed:
    - name: oledump
    - pkgrepo: remnux
    - require:
      - sls: remnux.python-packages.yara-python3
      - sls: remnux.python-packages.olefile
      - sls: remnux.python-packages.pyzipper

remnux-packages-oledump-shebang:
  file.replace:
    - name: /opt/oledump-files/oledump.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pkg: remnux-packages-oledump