include:
  - remnux.packages.python-pip

pip:
  pip.installed:
    - require:
      - pkg: python-pip
