include:
  - remnux.python3-packages.pip

remnux-python3-packages-requests:
  pip.installed:
    - name: requests==2.31.0
    - bin_env: /usr/bin/python3
    - upgrade: False
    - force_reinstall: True
    - require:
      - sls: remnux.python3-packages.pip
