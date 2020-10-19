include:
  - remnux.packages.python3-pip

pycryptodome==3.9.7:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: False
    - require:
      - sls: remnux.packages.python3-pip
