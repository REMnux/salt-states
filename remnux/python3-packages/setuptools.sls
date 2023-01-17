include:
  - remnux.python3-packages.pip

remnux-python3-packages-setuptools:
  pip.installed:
    - name: 'setuptools<66.0.0'
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
