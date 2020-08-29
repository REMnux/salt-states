include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-olefile:
  pip.installed:
    - name: olefile
    - bin_env: /usr/bin/python
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip

remnux-python-packages-olefile3:
  pip.installed:
    - name: olefile
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip