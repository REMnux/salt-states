include:
  - remnux.packages.python-pip

six:
  pip.installed:
    - name: six >= 1.6
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip
