include:
  - remnux.packages.python-pip

remnux-pip-pip:
  pip.installed:
    - name: pip >= 9.0
    - require:
      - sls: remnux.packages.python-pip
