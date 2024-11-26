# Name: pyenchant
# Website: https://pyenchant.github.io/pyenchant/
# Description: Spellchecking library for Python, based on the Enchant library.
# Category: 
# Author: Dimitri Merejkowsky
# License: GNU Lesser General Public License v2.1 (https://github.com/pyenchant/pyenchant/blob/main/LICENSE.txt)
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-pyenchant-venv:
  virtualenv.managed:
    - name: /opt/pyenchant
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-pyenchant:
  pip.installed:
    - name: pyenchant
    - bin_env: /opt/pyenchant/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-pyenchant-venv
