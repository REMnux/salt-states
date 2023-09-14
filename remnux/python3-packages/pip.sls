include:
  - remnux.packages.python3-pip

remnux-python3-packages-pip3:
  pip.installed:
    - name: pip>=23.2.1
    - bin_env: /usr/bin/python3
    - upgrade: True
    - force_reinstall: True
    - require:
      - sls: remnux.packages.python3-pip
