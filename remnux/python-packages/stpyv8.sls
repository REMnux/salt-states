include:
  - remnux.packages.git
  - remnux.packages.python3-pip
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-system-dev
  - remnux.packages.libboost-dev
  - remnux.packages.python3-setuptools
  - remnux.packages.python-pip
  - remnux.packages.build-essential
  - remnux.packages.sudo

remnux-pip-stpyv8:
  pip.installed:
    - name: git+https://github.com/area1/stpyv8
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.python3-setuptools
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.libboost-system-dev
      - sls: remnux.packages.libboost-dev
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.sudo