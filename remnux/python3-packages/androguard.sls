# Name: androguard
# Website: https://github.com/androguard/androguard
# Description: Examine Android files.
# Category: Statically Analyze Code: Android
# Author: Anthony Desnos, Geoffroy GueGuen
# License: Apache License 2.0: https://github.com/androguard/androguard/blob/master/LICENCE-2.0
# Notes: androguard

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-pyqt5

remnux-python3-packages-androguard-virtualenv:
  virtualenv.managed:
    - name: /opt/androguard
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - pyperclip
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-androguard:
  pip.installed:
    - name: androguard
    - bin_env: /opt/androguard/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-androguard-virtualenv
      - sls: remnux.packages.python3-pyqt5

remnux-python3-packages-androguard-symlink:
  file.symlink:
    - name: /usr/local/bin/androguard
    - target: /opt/androguard/bin/androguard
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-androguard
