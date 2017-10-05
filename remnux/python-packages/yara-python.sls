include:
  - remnux.python-packages.pip

yara-python:
  pip.installed:
    - require:
      - pip: pip
