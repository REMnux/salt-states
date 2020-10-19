include:
  - remnux.packages.python3-pip

remnux-python3-packages-protobuf-install:
  pip.installed:
    - name: protobuf
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
