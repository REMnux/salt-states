include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-protobuf-install:
  pip.installed:
    - name: protobuf
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
