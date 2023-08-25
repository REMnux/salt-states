include:
  - remnux.python3-packages.pip

importlib-metadata==4.13.0:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: False
    - require:
      - sls: remnux.python3-packages.pip
