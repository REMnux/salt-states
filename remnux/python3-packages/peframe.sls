# Name: PEframe
# Website: https://github.com/digitalsleuth/peframe
# Description: Statically analyze PE and Microsoft Office files.
# Category: Examine Static Properties: PE Files
# Author: Gianni Amato: https://twitter.com/guelfoweb
# License: Free, unknown license
# Notes: peframe

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.build-essential
  - remnux.packages.libncurses
  - remnux.packages.libmagic-dev
  - remnux.packages.python3-dev

remnux-python3-packages-peframe-venv:
  virtualenv.managed:
    - name: /opt/peframe
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-peframe:
  pip.installed:
    - name: peframe-ds
    - bin_env: /opt/peframe/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-peframe-venv
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.libncurses
      - sls: remnux.packages.libmagic-dev
      - sls: remnux.packages.python3-dev

remnux-python3-packages-peframe-symlink:
  file.symlink:
    - name: /usr/local/bin/peframe
    - target: /opt/peframe/bin/peframe
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-peframe
