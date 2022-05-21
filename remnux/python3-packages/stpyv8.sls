# Name: STPyV8
# Website: https://github.com/area1/stpyv8
# Description: Python3 and JavaScript interop engine, fork of the original PyV8 project
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Area1 Security
# License: Apache License 2.0: https://github.com/area1/stpyv8/blob/master/LICENSE.txt
# Notes:
{%- set version="v8.8.278.17" %}
{%- if grains['oscodename'] == "bionic" %} 
  {%- set release="stpyv8-ubuntu-18.04-python-3.6.zip" %}
  {%- set hash="f4644f87379458d00bc019f89a4a480f1ac85b84c5c74f4fa0732f631907b951" %}
  {%- set wheel="stpyv8-8.8.278.17-cp36-cp36m-linux_x86_64.whl" %}
  {%- set folder="stpyv8-ubuntu-18.04-3.6" %}
{% elif grains['oscodename'] == "focal" %} 
  {%- set release="stpyv8-ubuntu-20.04-python-3.8.zip" %}
  {%- set hash="660bb8dc558d6546deee5c6de12c18336247794c06ee3e784641bbefdb44d679" %}
  {%- set wheel="stpyv8-10.1.124.12-cp38-cp38-linux_x86_64.whl" %}
  {%- set folder="stpyv8-ubuntu-20.04-3.8" %}
{%- endif %}

include:
  - remnux.packages.sudo
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-system-dev
  - remnux.packages.libboost-dev
  - remnux.packages.build-essential
  - remnux.python3-packages.pip
  - remnux.python3-packages.setuptools

remnux-python3-packages-stpyv8-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ release }}
    - source: https://github.com/area1/stpyv8/releases/download/{{ version }}/{{ release }}
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-python3-packages-stpyv8-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/
    - source: /usr/local/src/remnux/files/{{ release }}
    - enforce_toplevel: False
    - watch:
      - file: remnux-python3-packages-stpyv8-source

remnux-pip3-stpyv8:
  pip.installed:
    - name: /usr/local/src/remnux/{{ folder }}/{{ wheel }}
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.sudo
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-system-dev
      - sls: remnux.packages.libboost-dev
      - sls: remnux.python3-packages.setuptools

