include:
  - remnux.packages.python3-pip

remnux-python3-packages-pip3:
  pip.installed:
    - name: pip>=21.2.4
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
