include:
  - remnux.python3-packages.pip

remnux-python3-packages-protobuf-install:
  pip.installed:
    - name: protobuf
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
