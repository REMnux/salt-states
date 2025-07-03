# Name: msoffcrypto-tool
# Website: https://github.com/nolze/msoffcrypto-tool
# Description: Decrypt a Microsoft Office file with password, intermediate key, or private key which generated its escrow key.
# Category: Analyze Documents: Microsoft Office
# Author: nolze
# License: MIT License: https://github.com/nolze/msoffcrypto-tool/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-msoffcrypto-tool-venv:
  virtualenv.managed:
    - name: /opt/msoffcrypto-tool
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-msoffcrypto-tool:
  pip.installed:
    - name: msoffcrypto-tool
    - bin_env: /opt/msoffcrypto-tool/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-msoffcrypto-tool-venv

remnux-python3-packages-msoffcrypto-tool-symlink:
  file.symlink:
    - name: /usr/local/bin/msoffcrypto-tool
    - target: /opt/msoffcrypto-tool/bin/msoffcrypto-tool
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-msoffcrypto-tool
