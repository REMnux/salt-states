# Name: PEframe
# Website: https://github.com/guelfoweb/peframe
# Description: Statically analyze PE and Microsoft Office files.
# Category: Examine Static Properties: PE Files
# Author: Gianni Amato: https://twitter.com/guelfoweb
# License: Free, unknown license
# Notes: peframe

include:
  - remnux.packages.git
  - remnux.packages.libssl-dev
  - remnux.packages.swig
  - remnux.packages.python3-pip

{%- if grains['oscodename'] == "bionic" %}
remnux-python3-packages-peframe:
  pip.installed:
    - name: git+https://github.com/guelfoweb/peframe.git@master
    - upgrade: True
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.swig
      - sls: remnux.packages.python3-pip

{%- elif grains['oscodename'] == "focal" %}
remnux-python3-packages-peframe:
  git.cloned:
    - name: https://github.com/guelfoweb/peframe.git
    - target: /usr/local/src/peframe
    - require:
      - sls: remnux.packages.git

remnux-python3-packages-peframe-setup:
  file.replace:
    - name: /usr/local/src/peframe/setup.py
    - pattern: "'peframe=peframe.peframecli'"
    - repl: "'peframe=peframe.peframecli:main'"
    - count: 1
    - require:
      - git: remnux-python3-packages-peframe

remnux-python3-packages-peframe-install:
  pip.installed:
    - name: /usr/local/src/peframe
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.swig

{%- endif %}
