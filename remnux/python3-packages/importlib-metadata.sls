include:
  - remnux.python3-packages.pip

importlib-metadata:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip