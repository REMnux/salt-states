# Name: pydot
# Website: https://github.com/pydot/pydot
# Description: Python interface to Graphviz and DOT
# Category: 
# Author: https://github.com/orgs/pydot/people
# License: MIT and Python Software Foundation (https://github.com/pydot/pydot/tree/main/LICENSES)
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-pydot-venv:
  virtualenv.managed:
    - name: /opt/pydot
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-pydot:
  pip.installed:
    - name: pydot
    - bin_env: /opt/pydot/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-pydot-venv
