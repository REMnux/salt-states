# Name: STPyV8
# Website: https://github.com/cloudflare/stpyv8
# Description: Python3 and JavaScript interop engine, fork of the original PyV8 project
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Area1 Security
# License: Apache License 2.0: https://github.com/cloudflare/stpyv8/blob/master/LICENSE.txt
# Notes:
{%- set version="11.7.439.19" %}
{%- if grains['oscodename'] == "bionic" %} 
Ubuntu Bionic is no longer supported:
  test.nop
{% elif grains['oscodename'] == "focal" %} 
  {%- set release="stpyv8-ubuntu-20.04-python-3.8.zip" %}
  {%- set hash="bf6821faf6669e07057478edf22c0e02351e7922494dbff377f216920235d8b7" %}
  {%- set wheel="stpyv8-" + version + "-cp38-cp38-linux_x86_64.whl" %}
  {%- set folder="stpyv8-ubuntu-20.04-3.8" %}

include:
  - remnux.packages.sudo
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-system-dev
  - remnux.packages.libboost-iostreams-dev
  - remnux.packages.libboost-dev
  - remnux.packages.build-essential
  - remnux.python3-packages.pip
  - remnux.python3-packages.setuptools

remnux-python3-packages-stpyv8-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ release }}
    - source: https://github.com/cloudflare/stpyv8/releases/download/v{{ version }}/{{ release }}
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
      - sls: remnux.packages.libboost-iostreams-dev
      - sls: remnux.python3-packages.setuptools
{%- endif %}
