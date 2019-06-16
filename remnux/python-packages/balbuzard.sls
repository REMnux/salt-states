# Source: https://bitbucket.org/decalage/balbuzard
# Author: Philippe Lagadec

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.python-packages.yara-python

remnux-pip-balbuzard:
  pip.installed:
    - name: balbuzard
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.python-packages.yara-python
