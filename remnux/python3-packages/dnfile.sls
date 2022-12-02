# Name: dnfile
# Website: https://github.com/malwarefrank/dnfile
# Description: Parse .NET executable files.
# Category: Statically Analyze Code: .NET
# Author: MalwareFrank
# License: MIT License: https://github.com/malwarefrank/dnfile/blob/master/LICENSE
# Notes: To use this library, create a Python program that imports it and loads the .NET file, as described in https://github.com/malwarefrank/dnfile/blob/master/README.rst.

include:
  - remnux.python3-packages.pip
  - remnux.python3-packages.pefile

remnux-python3-packages-dnfile:
  pip.installed:
    - name: dnfile
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.python3-packages.pefile
