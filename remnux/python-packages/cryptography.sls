include:
  - remnux.packages.python-pip

cryptography:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip