include:
  - remnux.python3-packages.pip

r2pipe:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
