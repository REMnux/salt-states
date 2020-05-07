include:
  - remnux.packages.python-pip
  - remnux.python-packages.six
  - remnux.python-packages.setuptools

cybox:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
      - pip: six
      - pip: setuptools
