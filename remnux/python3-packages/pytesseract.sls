include:
  - remnux.python3-packages.pip

pytesseract:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
