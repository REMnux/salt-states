include:
  - remnux.packages.python3-pip

remnux-python3-packages-pylzma:
  pip.installed:
    - name: pylzma
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
