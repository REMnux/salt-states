include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip

six:
  pip.installed:
    - bin_env: /usr/bin/python2
    - name: six >= 1.6
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
