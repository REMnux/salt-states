include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip

pysocks:
  pip.installed:
    - bin_env: /usr/bin/python2
    - upgrade: True
    - name: pysocks
    - require:
      - sls: remnux.packages.python2-pip
