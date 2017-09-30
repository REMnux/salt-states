# Source: https://github.com/decalage2/oletools
# License: MIT

include:
  - remnux.packages.git
  - remnux.packages.python-pip

remnux-python-oletools:
  pip.installed:
    - name: git+https://github.com/decalage2/oletools.git@3681c31
    - require:
      - pkg: git
      - pkg: python-pip
