include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

pysocks:
  pip.installed:
    - bin_env: /usr/bin/python
    - name: pysocks
    - require:
      - pkg: python-pip
