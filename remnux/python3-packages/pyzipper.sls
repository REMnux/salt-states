include:
  - remnux.python3-packages.pip
  - remnux.python3-packages.pycryptodomex

remnux-python3-packages-pyzipper:
  pip.installed:
    - name: pyzipper
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.python3-packages.pycryptodomex
