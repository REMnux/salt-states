include:
  - remnux.packages.python-pip

bitstring:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip