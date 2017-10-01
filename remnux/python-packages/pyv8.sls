include:
  - remnux.packages.git
  - remnux.packages.python-pip

remnux-pip-pyv8:
  pip.installed:
    - name: git+https://github.com/buffer/pyv8.git
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
