include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-pyperclip-install:
  pip.installed:
    - name: pyperclip
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
