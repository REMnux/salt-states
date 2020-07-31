include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

six:
  pip.installed:
    - bin_env: /usr/bin/python
    - name: six >= 1.6
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip
