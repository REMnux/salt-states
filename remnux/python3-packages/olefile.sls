include:
  - remnux.python3-packages.pip

remnux-python3-packages-olefile3:
  pip.installed:
    - name: olefile
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
