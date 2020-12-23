include:
  - remnux.packages.python3-pip

remnux-python3-packages-olefile3:
  pip.installed:
    - name: olefile
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
