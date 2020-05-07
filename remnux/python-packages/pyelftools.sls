include:
  - remnux.packages.python-pip

pyelftools:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
