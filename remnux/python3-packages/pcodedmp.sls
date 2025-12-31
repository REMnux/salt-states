# Name: pcodedmp
# Website: https://github.com/bontchev/pcodedmp
# Description: Disassemble VBA p-code.
# Category: Analyze Documents: Microsoft Office
# Author: Vesselin Bontchev: https://twitter.com/bontchev
# License: GNU General Public License (GPL) v3: https://github.com/bontchev/pcodedmp/blob/master/LICENSE
# Notes:

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-pcodedmp-venv:
  virtualenv.managed:
    - name: /opt/pcodedmp
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-pcodedmp:
  pip.installed:
    - name: pcodedmp
    - bin_env: /opt/pcodedmp/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-pcodedmp-venv

remnux-python3-packages-pcodedmp-symlink:
  file.symlink:
    - name: /usr/local/bin/pcodedmp
    - target: /opt/pcodedmp/bin/pcodedmp
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-pcodedmp
