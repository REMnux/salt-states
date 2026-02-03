# Name: dllcharacteristics.py
# Website: https://github.com/accidentalrebel/dllcharacteristics.py
# Description: Read and set DLL characteristics of a PE file.
# Category: Examine Static Properties: PE Files
# Author: Karlo Licudine: https://x.com/accidentalrebel
# License: GNU General Public License (GPL) v3.0: https://github.com/accidentalrebel/dllcharacteristics.py/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-scripts-dllcharacteristics-venv:
  virtualenv.managed:
    - name: /opt/dllcharacteristics
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - pefile
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-dllcharacteristics:
  file.managed:
    - name: /opt/dllcharacteristics/bin/dllcharacteristics.py
    - source: https://raw.githubusercontent.com/accidentalrebel/dllcharacteristics.py/master/dllcharacteristics.py
    - source_hash: sha256=b0f8ebb322954f44c784bb70bf500a093b067d7a68022be8e77046e5d83bba09
    - makedirs: false
    - mode: 755
    - require:
      - virtualenv: remnux-scripts-dllcharacteristics-venv

remnux-scripts-dllcharacteristics-symlink:
  file.symlink:
    - name: /usr/local/bin/dllcharacteristics.py
    - target: /opt/dllcharacteristics/bin/dllcharacteristics.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-dllcharacteristics

remnux-scripts-dllcharacteristics-shebang:
  file.replace:
    - name: /opt/dllcharacteristics/bin/dllcharacteristics.py
    - pattern: '#!/usr/bin/python3\n'
    - repl: '#!/opt/dllcharacteristics/bin/python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-dllcharacteristics-symlink
