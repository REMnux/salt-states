include:
  - remnux.python3-packages.pip
  - remnux.packages.libemu

remnux-python3-packages-pylibemu:
  pip.installed:
    - name: pylibemu
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.libemu
