include:
  - remnux.packages.python3-pip

remnux-python3-packages-pip3:
  pip.installed:
    - name: pip==21.0.1
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
