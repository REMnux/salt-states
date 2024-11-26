# Name: bottle
# Website: https://bottlepy.org/docs/dev/
# Description: Python Web Framework
# Category: 
# Author: https://github.com/bottlepy/bottle/blob/master/AUTHORS
# License: MIT (https://github.com/bottlepy/bottle/blob/master/LICENSE)
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-bottle-venv:
  virtualenv.managed:
    - name: /opt/bottle
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-bottle:
  pip.installed:
    - name: bottle
    - bin_env: /opt/bottle/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-bottle-venv

remnux-python3-package-bottle-symlink:
  file.symlink:
    - name: /usr/local/bin/bottle
    - target: /opt/bottle/bin/bottle
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-bottle
