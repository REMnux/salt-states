# Name: dnfile
# Website: https://github.com/malwarefrank/dnfile
# Description: Analyze static properties of .NET files.
# Category: Examine Static Properties: .NET
# Author: MalwareFrank
# License: MIT License: https://github.com/malwarefrank/dnfile/blob/master/LICENSE
# Notes: To use this library, create a Python program that imports it and loads the .NET file, as described in https://github.com/malwarefrank/dnfile/blob/master/README.rst.

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-dnfile-venv:
  virtualenv.managed:
    - name: /opt/dnfile
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - pefile
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-dnfile:
  pip.installed:
    - name: dnfile
    - bin_env: /opt/dnfile/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-dnfile-venv
