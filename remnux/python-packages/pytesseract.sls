include:
  - remnux.packages.python3-pip
  - remnux.packages.python3
  - remnux.packages.python-pip

remnux-pytesseract:
  pip.installed:
    - name: pytesseract
    - bin_env: /usr/bin/pip3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python-pip