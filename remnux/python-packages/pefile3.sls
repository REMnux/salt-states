include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-pefile3:
  pip.installed:
    - name: pefile
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.python3-pip
