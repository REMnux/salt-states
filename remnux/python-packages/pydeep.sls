include:
  - remnux.packages.python-pip
  - remnux.packages.libfuzzy-dev

pydeep:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.libfuzzy-dev