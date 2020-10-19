include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip

pype32:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip
