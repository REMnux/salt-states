# Name: shcode2exe
# Website: https://github.com/accidentalrebel/shcode2exe
# Description: Convert 32 and 64-bit shellcode to a Windows executable file.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: Karlo Licudine: https://twitter.com/accidentalrebel
# License: GNU General Public License (GPL) v3.0: https://github.com/accidentalrebel/shcode2exe/blob/master/LICENSE
# Notes: 

{% set commit = '6eaf442c6c3613f9fb9d10b0188358e6dd528722' %}
{% set hash = '4a1e9e34fe6f8926210872e842cee5dcbe1e401e25669c8d3746f12a82b9ecf3' %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.nasm
  - remnux.packages.binutils

remnux-scripts-shcode2exe-venv:
  virtualenv.managed:
    - name: /opt/shcode2exe
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-shcode2exe:
  file.managed:
    - name: /opt/shcode2exe/bin/shcode2exe.py
    - source: https://github.com/accidentalrebel/shcode2exe/raw/{{ commit }}/shcode2exe.py
    - source_hash: sha256={{ hash }}
    - makedirs: False
    - mode: 755
    - require:
      - sls: remnux.packages.nasm
      - sls: remnux.packages.binutils

remnux-scripts-shcode2exe-symlink:
  file.symlink:
    - name: /usr/local/bin/shcode2exe.py
    - target: /opt/shcode2exe/bin/shcode2exe.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-shcode2exe

remnux-scripts-shcode2exe-shebang:
  file.replace:
    - name: /opt/shcode2exe/bin/shcode2exe.py
    - pattern: '#!/usr/bin/env python3\n'
    - repl: '#!/opt/shcode2exe/bin/python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-shcode2exe-symlink
