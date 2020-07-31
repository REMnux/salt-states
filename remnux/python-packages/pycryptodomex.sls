include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

pycryptodomex:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: pycryptodomex == 3.7.3
    - require:
      - sls: remnux.packages.python3-pip
