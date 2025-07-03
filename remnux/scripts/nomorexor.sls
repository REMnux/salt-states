# Name: NoMoreXOR.py
# Website: https://github.com/digitalsleuth/NoMoreXOR
# Description: Help guess a file's 256-byte XOR by using frequency analysis.
# Category: Examine Static Properties: Deobfuscation
# Author: Glenn P. Edwards Jr.
# License: Free, unknown license
# Notes:

include:
  - remnux.packages.python3-virtualenv

remnux-scripts-nomorexor-venv:
  virtualenv.managed:
    - name: /opt/nomorexor
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - yara-python
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-nomorexor:
  file.managed:
  - name: /opt/nomorexor/bin/nomorexor.py
  - source: https://github.com/digitalsleuth/NoMoreXOR/raw/master/nomorexor.py
  - source_hash: sha256=597fccfa5983f50bd50539e1d451e32144e4adf9027a577125263d4e28b402c5
  - mode: 755
  - makedirs: false
  - require:
    - virtualenv: remnux-scripts-nomorexor-venv

remnux-scripts-nomorexor-symlink:
  file.symlink:
    - name: /usr/local/bin/nomorexor.py
    - target: /opt/nomorexor/bin/nomorexor.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-nomorexor
