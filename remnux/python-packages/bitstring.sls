include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

bitstring:
  pip.installed:
    - bin_env: /usr/bin/python
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip