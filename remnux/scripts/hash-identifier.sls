# Name: Hash ID
# Website: https://github.com/blackploit/hash-identifier
# Description: Identify dfferent types of hashes.
# Category: Examine Static Properties: General
# Author: Zion3R
# License: GNU General Public License (GPL) v3
# Notes: hash-id.py

include:
  - remnux.packages.python3-virtualenv

remnux-scripts-hash-identifier-venv:
  virtualenv.managed:
    - name: /opt/hash-identifier
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-hash-identifier:
  file.managed:
    - name: /opt/hash-identifier/bin/hash-id.py
    - source: https://github.com/blackploit/hash-identifier/raw/master/hash-id.py
    - source_hash: sha256=d523ad28ccb6fa9635b74255de7938b94e860c3a6fad1f94ebbc0000b56a64f2
    - mode: 755
    - require:
      - virtualenv: remnux-scripts-hash-identifier-venv

remnux-scripts-hash-identifier-symlink:
  file.symlink:
    - name: /usr/local/bin/hash-id.py
    - target: /opt/hash-identifier/bin/hash-id.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-hash-identifier

remnux-scripts-hash-identifier-shebang:
  file.replace:
    - name: /opt/hash-identifier/bin/hash-id.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/opt/hash-identifier/bin/python3\n'
    - prepend_if_not_found: False
    - backup: False
    - count: 1
    - watch:
      - file: remnux-scripts-hash-identifier-symlink

remnux-scripts-hash-identifier-formatting:
  file.replace:
    - name: /opt/hash-identifier/bin/hash-id.py
    - pattern: '\r'
    - repl: ''
    - backup: False
    - watch:
      - file: remnux-scripts-hash-identifier-shebang
