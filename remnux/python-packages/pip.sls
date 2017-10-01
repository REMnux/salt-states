include:
  - remnux.packages.python-pip

remnux-pip-pip:
  pip.installed:
    - name: pip
    - require:
      - sls: remnux.packages.python-pip
