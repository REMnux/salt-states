# Name: uncompyle6
# Website: https://github.com/rocky/python-uncompyle6
# Description: Python cross-version bytecode decompiler for Python 1.0 through 3.8.
# Category: Statically Analyze Code: Python
# Author: Rocky Bernstein: https://github.com/rocky
# License: GNU General Public License v3.0: https://github.com/rocky/python-uncompyle6/blob/master/COPYING
# Notes: uncompyle6

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-uncompyle6-venv:
  virtualenv.managed:
    - name: /opt/uncompyle6
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-uncompyle6:
  pip.installed:
    - name: uncompyle6
    - bin_env: /opt/uncompyle6/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-uncompyle6-venv

remnux-python3-packages-uncompyle6-symlink:
  file.symlink:
    - name: /usr/local/bin/uncompyle6
    - target: /opt/uncompyle6/bin/uncompyle6
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-uncompyle6
