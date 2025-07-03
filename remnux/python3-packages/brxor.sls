# Name: brxor.py
# Website: https://github.com/REMnux/distro/blob/master/files/brxor.py
# Description: Bruteforce XOR'ed strings to find those that are English words.
# Category: Examine Static Properties: Deobfuscation
# Author: Alexander Hanel, Trenton Tait
# License: Free, unknown license
# Notes:

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.enchant

remnux-python3-packages-brxor-venv:
  virtualenv.managed:
    - name: /opt/brxor
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - pyenchant
    - require:
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.enchant

remnux-python3-packages-brxor:
  file.managed:
    - name: /opt/brxor/bin/brxor.py
    - source: https://github.com/REMnux/distro/raw/master/files/brxor.py
    - source_hash: sha256=30660b241220382fd599befa7f38c999a5bdb93c0a2730d775e33ce4c7722db2
    - makedirs: false
    - mode: 755
    - require:
      - virtualenv: remnux-python3-packages-brxor-venv

remnux-python3-packages-brxor-symlink:
  file.symlink:
    - name: /usr/local/bin/brxor.py
    - target: /opt/brxor/bin/brxor.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-python3-packages-brxor
