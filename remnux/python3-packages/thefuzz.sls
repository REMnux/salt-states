# Name: thefuzz
# Website: https://github.com/seatgeek/thefuzz
# Description: Fuzzy String Matching in Python
# Category: 
# Author: 
# License: 
# Notes: Updated implementation of fuzzywuzzy

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-thefuzz-venv:
  virtualenv.managed:
    - name: /opt/thefuzz
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-thefuzz:
  pip.installed:
    - name: thefuzz
    - bin_env: /opt/thefuzz/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-thefuzz-venv
