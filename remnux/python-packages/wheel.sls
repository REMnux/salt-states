include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

wheel:
  pip.installed:
    - bin_env: /usr/bin/python
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip
