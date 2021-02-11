include:
  - remnux.python3-packages.pip

remnux-python3-packages-colorama:
  pip.installed:
    - name: colorama
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
