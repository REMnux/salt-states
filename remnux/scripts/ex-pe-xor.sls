# Name: ex_pe_xor.py
# Website: http://hooked-on-mnemonics.blogspot.com/2014/04/expexorpy.html
# Description: Search an XOR'ed file for indications of executable binaries.
# Category: Examine Static Properties: Deobfuscation
# Author: Alexander Hanel
# License: Free, unknown license
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-scripts-ex-pe-xor-venv:
  virtualenv.managed:
    - name: /opt/ex-pe-xor
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - pefile
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-ex-pe-xor:
  file.managed:
    - name: /opt/ex-pe-xor/bin/ex-pe-xor.py
    - source: https://github.com/digitalsleuth/ex_pe_xor/raw/master/ex_pe_xor.py
    - source_hash: sha256=0bd20c4dd899a457d3625cb37397c6341582a4d1e71b76bf05b62cd830e40570
    - makedirs: false
    - mode: 755
    - require:
      - virtualenv: remnux-scripts-ex-pe-xor-venv

remnux-scripts-ex-pe-xor-symlink:
  file.symlink:
    - name: /usr/local/bin/ex-pe-xor.py
    - target: /opt/ex-pe-xor/bin/ex-pe-xor.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-ex-pe-xor

remnux-scripts-ex-pe-xor-shebang:
  file.replace:
    - name: /opt/ex-pe-xor/bin/ex-pe-xor.py
    - pattern: '#!/usr/bin/env python3\n'
    - repl: '#!/opt/ex-pe-xor/bin/python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-ex-pe-xor-symlink
