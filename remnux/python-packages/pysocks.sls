include:
  - remnux.packages.python-pip

pysocks:
  pip.installed:
    - name: pysocks
    - require:
      - pkg: python-pip