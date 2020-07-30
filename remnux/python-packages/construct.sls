include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

construct:
  pip.installed:
    - bin_env: /usr/bin/python
    - require:
      - sls: remnux.packages.python-pip
