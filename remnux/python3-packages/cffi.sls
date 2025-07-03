# Name: cffi
# Website: https://cffi.readthedocs.io/en/stable
# Description: Python tool for interacting with C code.
# Category: 
# Author: Armin Rigo, Maciej Fijalkowski (https://github.com/python-cffi/cffi/blob/main/AUTHORS)
# License: MIT License: https://github.com/python-cffi/cffi/blob/main/LICENSE
# Notes: /opt/cffi/bin/python3 - import cffi

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-cffi-venv:
  virtualenv.managed:
    - name: /opt/cffi
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-cffi:
  pip.installed:
    - name: cffi
    - bin_env: /opt/cffi/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-cffi-venv
