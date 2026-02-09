# Name: pyinstxtractor-ng
# Website: https://github.com/pyinstxtractor/pyinstxtractor-ng
# Description: Extract contents of PyInstaller-generated executables without requiring a matching Python version.
# Category: Statically Analyze Code: Python
# Author: extremecoders-re
# License: GNU General Public License v3.0: https://github.com/pyinstxtractor/pyinstxtractor-ng/blob/main/LICENSE
# Notes: pyinstxtractor-ng

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-pyinstxtractor-ng-venv:
  virtualenv.managed:
    - name: /opt/pyinstxtractor-ng
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-pyinstxtractor-ng:
  pip.installed:
    - name: pyinstxtractor-ng
    - bin_env: /opt/pyinstxtractor-ng/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-pyinstxtractor-ng-venv

remnux-python3-packages-pyinstxtractor-ng-symlink:
  file.symlink:
    - name: /usr/local/bin/pyinstxtractor-ng
    - target: /opt/pyinstxtractor-ng/bin/pyinstxtractor-ng
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-pyinstxtractor-ng
