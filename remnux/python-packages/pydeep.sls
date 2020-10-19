include:
  - remnux.packages.python2-pip
  - remnux.packages.libfuzzy-dev
  - remnux.packages.python3-pip

pydeep:
  pip.installed:
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.libfuzzy-dev
