include:
  - remnux.packages.python-pip

ipwhois:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
