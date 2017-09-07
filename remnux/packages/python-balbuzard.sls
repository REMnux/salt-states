# Source: https://github.com/decalage2/balbuzard

include:
  - remnux.packages.git
  - remnux.packages.python-pip

remnux-python-balbuzard:
  pip.installed:
    - name: git+https://github.com/decalage2/balbuzard.git@597964a
    - require:
      - pkg: git
      - pkg: python-pip
