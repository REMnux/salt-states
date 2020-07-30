include:
  - remnux.packages.python-pip
  - remnux.packages.libfuzzy-dev
  - remnux.packages.python3-pip

pydeep:
  pip.installed:
    - bin_env: /usr/bin/python
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.libfuzzy-dev
