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

remnux-scripts-brxor-venv:
  virtualenv.managed:
    - name: /opt/brxor
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-brxor-requirements:
  pip.installed:
    - name: pyenchant
    - bin_env: /opt/brxor/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-scripts-brxor-venv

remnux-scripts-brxor-source:
  file.managed:
    - name: /opt/brxor/bin/brxor.py
    - source: salt://remnux/scripts/files/brxor.py
    - makedirs: false
    - mode: 755
    - require:
      - pip: remnux-scripts-brxor-requirements

remnux-scripts-brxor-symlink:
  file.symlink:
    - name: /usr/local/bin/brxor.py
    - target: /opt/brxor/bin/brxor.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-brxor-source
