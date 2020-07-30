include:
  - remnux.packages.python3-pip
  - remnux.packages.python-pip

pytesseract:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
