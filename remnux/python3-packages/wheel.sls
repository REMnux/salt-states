include:
  - remnux.python3-packages.pip

remnux-python3-packages-wheel:
  pip.installed:
    - name: wheel==0.36.2
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
