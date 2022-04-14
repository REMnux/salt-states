include:
  - remnux.python3-packages.pip
  - remnux.python3-packages.setuptools-rust

docker-compose:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.python3-packages.setuptools-rust
