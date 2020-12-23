include:
  - remnux.packages.python3-pip

remnux-python3-packages-wheel:
  pip.installed:
    - name: wheel
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
