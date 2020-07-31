include:
  - remnux.packages.libssl-dev
  - remnux.packages.python-pip
  - remnux.packages.python-m2crypto
  - remnux.python-packages.m2crypto
  - remnux.packages.python3-pip

dpapick:
  pip.installed:
    - name: dpapick
    - bin_env: /usr/bin/python
    - upgrade: True
    - require:
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python-m2crypto
      - sls: remnux.python-packages.m2crypto
