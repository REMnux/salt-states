# Name: thefuzz
# Website: https://github.com/seatgeek/thefuzz
# Description: Fuzzy String Matching in Python.
# Category: Examine Static Properties: General
# Author: SeatGeek
# License: MIT License: https://github.com/seatgeek/thefuzz/blob/master/LICENSE.txt
# Notes: Updated implementation of fuzzywuzzy

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-thefuzz-venv:
  virtualenv.managed:
    - name: /opt/thefuzz
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-thefuzz:
  pip.installed:
    - name: thefuzz
    - bin_env: /opt/thefuzz/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-thefuzz-venv

