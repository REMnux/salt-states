# Name: extract_swf
# Website: https://github.com/digitalsleuth/extract_swf
# Description: Extract potential SWF files from Flash Projector binaries.
# Category: Statically Analyze Code: Flash
# Author: Nathan Ostgard, Updated for Python 3 by Corey Forman
# License: Free, unknown license
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-scripts-extract-swf-venv:
  virtualenv.managed:
    - name: /opt/extract-swf
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-extract-swf:
  file.managed:
    - name: /opt/extract-swf/bin/extract_swf.py
    - source: https://raw.githubusercontent.com/digitalsleuth/extract_swf/master/extract_swf.py
    - source_hash: 474b4e296be86c245fec8e28e435398c5d6ada736de1552ff21950419ccb282b
    - mode: 755
    - require:
      - virtualenv: remnux-scripts-extract-swf-venv

remnux-scripts-extract-swf-symlink:
  file.symlink:
    - name: /usr/local/bin/extract_swf.py
    - target: /opt/extract-swf/bin/extract_swf.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-extract-swf

remnux-scripts-extract-swf-shebang:
  file.replace:
    - name: /opt/extract-swf/bin/extract_swf.py
    - pattern: '#!/usr/bin/env python3\n'
    - repl: '#!/opt/extract-swf/bin/python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-extract-swf-symlink
