# Name: xortool
# Website: https://github.com/hellman/xortool
# Description: Analyze XOR-encoded data.
# Category: Examine Static Properties: Deobfuscation
# Author: Aleksei Hellman
# License: MIT License: https://github.com/hellman/xortool/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-xortool-venv:
  virtualenv.managed:
    - name: /opt/xortool
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-xortool:
  pip.installed:
    - name: xortool
    - bin_env: /opt/xortool/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-xortool-venv

remnux-python3-packages-xortool-symlink:
  file.symlink:
    - name: /usr/local/bin/xortool
    - target: /opt/xortool/bin/xortool
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-xortool
