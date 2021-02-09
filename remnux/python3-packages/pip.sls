include:
  - remnux.packages.python3-pip

remnux-python3-packages-pip3:
  pip.installed:
    - name: pip
    - upgrade: True
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip