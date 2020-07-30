include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

docker-compose:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
