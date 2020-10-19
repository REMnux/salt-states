{%- if grains['oscodename'] == "bionic" %}
include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip

yara-python:
  pip.installed:
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip

{%- elif grains['oscodename'] == "focal" %}
include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip
  - remnux.packages.python2-dev

yara-python:
  pip.installed:
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.python2-dev

{%- endif %}
