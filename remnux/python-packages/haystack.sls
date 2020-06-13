include:
  - remnux.packages.python-pip

haystack:
  pip.installed:
    - name: haystack
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip