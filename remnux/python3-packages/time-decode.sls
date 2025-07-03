# Name: time-decode
# Website: https://github.com/digitalsleuth/time_decode
# Description: Decode and encode date and timestamps.
# Category: Gather and Analyze Data
# Author: Corey Forman
# License: MIT License: https://github.com/digitalsleuth/time_decode/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-time-decode-venv:
  virtualenv.managed:
    - name: /opt/time-decode
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-time-decode:
  pip.installed:
    - name: time-decode
    - bin_env: /opt/time-decode/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-time-decode-venv

remnux-python3-packages-time-decode-symlink:
  file.symlink:
    - name: /usr/local/bin/time-decode
    - target: /opt/time-decode/bin/time-decode
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-time-decode
