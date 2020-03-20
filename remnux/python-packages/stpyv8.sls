include:
  - remnux.packages.git
  - remnux.packages.python3-pip
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-thread-dev
  - remnux.packages.python3-setuptools
  - remnux.packages.python3-wheel
  - remnux.packages.python-pip

remnux-pip-stpyv8:
  pip.installed:
    - name: git+https://github.com/area1/stpyv8
    - bin_env: /usr/bin/pip3
    - install_options:
      - stpyv8/wheels/ubuntu-18.04/stpyv8-7.9.317.31-cp36-cp36m-linux_x86_64.whl
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-thread-dev
      - sls: remnux.packages.python3-setuptools
      - sls: remnux.packages.python3-wheel
      - sls: remnux.packages.python-pip