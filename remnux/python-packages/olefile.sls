include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-olefile:
  pip.installed:
    - name: olefile
    - bin_env: /usr/bin/pip
    - require:
      - sls: remnux.packages.python-pip

remnux-python-packages-olefile3:
  pip.installed:
    - name: olefile
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.python3-pip