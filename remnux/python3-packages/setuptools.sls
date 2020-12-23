include:
  - remnux.packages.python3-pip

remnux-python3-packages-setuptools:
  pip.installed:
    - name: setuptools
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
