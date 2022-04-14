include:
  - remnux.python3-packages.pip

remnux-python3-packages-setuptools:
  pip.installed:
    - name: setuptools
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
