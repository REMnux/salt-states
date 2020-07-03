include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-pylzma-python3:
  pip.installed:
    - name: pylzma
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
