include:
  - remnux.python-packages.pip

setuptools:
  pip.installed:
    - upgrade: True
    - require:
      - pip: pip
