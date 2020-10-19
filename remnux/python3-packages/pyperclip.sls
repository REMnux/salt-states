include:
  - remnux.packages.python3-pip

remnux-python3-packages-pyperclip:
  pip.installed:
    - name: pyperclip
    - upgrade: True
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
