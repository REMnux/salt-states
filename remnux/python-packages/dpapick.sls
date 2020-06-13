include:
  - remnux.packages.libssl-dev
  - remnux.packages.python-pip
  - remnux.packages.python-m2crypto
  - remnux.python-packages.m2crypto

dpapick:
  pip.installed:
    - name: dpapick
    - pip_bin: /usr/bin/pip
    - upgrade: True
    - require:
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python-m2crypto
      - sls: remnux.python-packages.m2crypto