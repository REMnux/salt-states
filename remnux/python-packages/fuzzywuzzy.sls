include:
  - remnux.packages.python-pip

fuzzywuzzy:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip