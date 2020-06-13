include:
  - remnux.packages.python-pip

pycoin:
  pip.installed:
    - name: pycoin
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip