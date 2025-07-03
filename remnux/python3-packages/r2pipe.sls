# Name: r2pipe
# Website: https://rada.re/n/r2pipe.html
# Description: Examine binary files, including disassembling and debugging.
# Category: Dynamically Reverse-Engineer Code: General
# Author: radareorg
# License: MIT
# Notes:

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-r2pipe-venv:
  virtualenv.managed:
    - name: /opt/r2pipe
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-r2pipe:
  pip.installed:
    - name: r2pipe
    - bin_env: /opt/r2pipe/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-r2pipe-venv
