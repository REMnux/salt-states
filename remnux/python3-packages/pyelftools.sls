# Name: pyelftools
# Website: https://github.com/eliben/pyelftools
# Description: Python library for parsing and analyzing ELF files and DWARF debugging information.
# Category: Examine Static Properties: ELF Files
# Author: Eli Bendersky
# License: Public Domain: https://github.com/eliben/pyelftools/blob/master/LICENSE
# Notes: readelf.py

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-pyelftools-venv:
  virtualenv.managed:
    - name: /opt/pyelftools
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-pyelftools:
  pip.installed:
    - name: pyelftools
    - bin_env: /opt/pyelftools/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-pyelftools-venv

remnux-python3-packages-pyelftools-symlink:
  file.symlink:
    - name: /usr/local/bin/readelf.py
    - target: /opt/pyelftools/bin/readelf.py
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-pyelftools
