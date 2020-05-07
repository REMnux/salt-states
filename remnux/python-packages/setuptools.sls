include:
  - remnux.packages.python-pip

setuptools:
  pip.installed:
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip
