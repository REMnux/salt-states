include:
  - remnux.python-packages.pip
  - remnux.python-packages.six
  - remnux.python-packages.setuptools

cybox:
  pip.installed:
    - require:
      - pip: pip
      - pip: six
      - pip: setuptools
