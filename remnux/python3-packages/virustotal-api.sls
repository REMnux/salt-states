# Name: VirusTotal API
# Website: https://github.com/VirusTotal/vt-py
# Description: Query and interact with VirusTotal using a command-line interface.
# Category: Gather and Analyze Data
# Author: VirusTotal
# License: Apache 2.0 (https://github.com/VirusTotal/vt-py/blob/master/LICENSE)
# Notes:

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-vt-py-venv:
  virtualenv.managed:
    - name: /opt/vt-py
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-vt-py:
  pip.installed:
    - name: vt-py
    - bin_env: /opt/vt-py/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-vt-py-venv
