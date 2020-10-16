include:
  - remnux.packages.python3-pip

r2pipe:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
