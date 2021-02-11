# Name: STPyV8
# Website: https://github.com/area1/stpyv8
# Description: Python3 and JavaScript interop engine, fork of the original PyV8 project
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Area1 Security
# License: Apache License 2.0: https://github.com/area1/stpyv8/blob/master/LICENSE.txt
# Notes:
{%- if grains['oscodename'] == "bionic" %} 
  {%- set release="stpyv8-8.6.395.10-cp36-cp36m-linux_x86_64.whl" %}
{% elif grains['oscodename'] == "focal" %} 
  {%- set release="stpyv8-8.6.395.10-cp38-cp38-linux_x86_64.whl" %}
{%- endif %}

include:
  - remnux.packages.sudo
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-system-dev
  - remnux.packages.libboost-dev
  - remnux.packages.build-essential
  - remnux.python3-packages.pip
  - remnux.python3-packages.setuptools

remnux-pip3-stpyv8:
  pip.installed:
    - name: https://github.com/area1/stpyv8/releases/download/v8.6.395.10/{{ release }}
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.sudo
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-system-dev
      - sls: remnux.packages.libboost-dev
      - sls: remnux.python3-packages.setuptools

