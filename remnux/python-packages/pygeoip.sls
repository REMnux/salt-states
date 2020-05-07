include:
  - remnux.packages.python-pip

pygeoip:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
