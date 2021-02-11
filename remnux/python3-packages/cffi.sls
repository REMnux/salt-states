include:
  - remnux.python3-packages.pip

remnux-python3-packages-cffi:
  pip.installed:
    - name: cffi
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
