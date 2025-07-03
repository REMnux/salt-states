# Name: Java IDX Parser
# Website: https://github.com/digitalsleuth/Java_IDX_Parser
# Description: Analyze Java IDX files.
# Category: Statically Analyze Code: Java
# Author: Brian Baskin: https://twitter.com/bbaskin, Updated for Python 3 by Corey Forman
# License: Apache License 2.0: https://github.com/digitalsleuth/Java_IDX_Parser/blob/master/LICENSE
# Notes: idx_parser.py

include:
  - remnux.packages.python3-virtualenv

remnux-scripts-java-idx-parser-venv:
  virtualenv.managed:
    - name: /opt/java-idx-parser
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-java-idx-parser:
  file.managed:
    - name: /opt/java-idx-parser/bin/idx_parser.py
    - source: https://raw.githubusercontent.com/digitalsleuth/Java_IDX_Parser/refs/heads/master/idx_parser/idx_parser.py
    - source_hash: sha256=0b024996b6009e0574b49be6083dd72d565b97dcf815150e302383139c0e3d26
    - mode: 755
    - require:
      - virtualenv: remnux-scripts-java-idx-parser-venv

remnux-scripts-java-idx-parser-symlink:
  file.symlink:
    - name: /usr/local/bin/idx_parser.py
    - target: /opt/java-idx-parser/bin/idx_parser.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-java-idx-parser

remnux-scripts-java-idx-parser-shebang:
  file.replace:
    - name: /opt/java-idx-parser/bin/idx_parser.py
    - pattern: '#! /usr/bin/env python3\n'
    - repl: '#!/opt/java-idx-parser/bin/python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-java-idx-parser-symlink
