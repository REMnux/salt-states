include:
  - remnux.packages.libssl-dev
  - remnux.packages.python2-pip
  - remnux.python-packages.m2crypto
  - remnux.packages.python3-pip

dpapick:
  pip.installed:
    - name: dpapick
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.python2-pip
      - sls: remnux.python-packages.m2crypto
