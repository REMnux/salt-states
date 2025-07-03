# Name: ioc_parser
# Website: https://github.com/buffer/ioc_parser
# Description: Extract IOCs from security report PDFs.
# Category: Gather and Analyze Data
# Author: Armin Buescher
# License: MIT License: https://github.com/buffer/ioc_parser/blob/master/LICENSE.txt
# Notes:

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.git

remnux-python3-packages-ioc-parser-venv:
  virtualenv.managed:
    - name: /opt/ioc-parser
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-ioc-parser:
  pip.installed:
    - name: git+https://github.com/buffer/ioc_parser.git
    - bin_env: /opt/ioc-parser/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-ioc-parser-venv

remnux-python3-packages-ioc-parser-symlink:
  file.symlink:
    - name: /usr/local/bin/iocp
    - target: /opt/ioc-parser/bin/iocp
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-ioc-parser
