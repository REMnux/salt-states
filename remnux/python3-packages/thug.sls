# Name: thug
# Website: https://github.com/buffer/thug
# Description: Examine suspicious website using this low-interaction honeyclient.
# Category: Explore Network Interactions: Connecting
# Author: Angelo Dell'Aera
# License: GNU General Public License (GPL) v2: https://github.com/buffer/thug/blob/master/LICENSE.txt
# Notes: thug -F

{%- set version="11.7.439.19" %}
{% if grains['oscodename'] == "focal" %}
  {% set py3_version="python3.9" %}
  {% set py3_dependency="python39" %} 
  {%- set release="stpyv8-ubuntu-20.04-python-3.9.zip" %}
  {%- set hash="b595998a67a9b70b9d97dc22fd0e36674f60629790f250458681413912692b8a" %}
  {%- set wheel="stpyv8-" + version + "-cp39-cp39-linux_x86_64.whl" %}
  {%- set folder="stpyv8-ubuntu-20.04-3.9" %}
{% elif grains['oscodename'] == "jammy" %}
  {% set py3_version="python3" %}
  {% set py3_dependency="python3" %} 
  {%- set release="stpyv8-ubuntu-22.04-python-3.10.zip" %}
  {%- set hash="757bb89229c659d517c23ec6fae56f5c76437fc3a72bbac7584805efcbe0b19e" %}
  {%- set wheel="stpyv8-" + version + "-cp310-cp310-linux_x86_64.whl" %}
  {%- set folder="stpyv8-ubuntu-22.04-3.10" %}
{% endif %}

include:
  - remnux.packages.git
  - remnux.python3-packages.pip
  - remnux.python3-packages.setuptools
  - remnux.packages.libemu
  - remnux.packages.libgraphviz-dev
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev
  - remnux.packages.libffi-dev
  - remnux.packages.libfuzzy-dev
  - remnux.packages.libfuzzy2
  - remnux.packages.libjpeg-dev
  - remnux.packages.tesseract-ocr
  - remnux.packages.libssl-dev
  - remnux.python3-packages.pytesseract
  - remnux.packages.virtualenv
  - remnux.packages.{{ py3_dependency }}
  - remnux.packages.{{ py3_dependency }}-dev
  - remnux.packages.sudo
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-system-dev
  - remnux.packages.libboost-iostreams-dev
  - remnux.packages.libboost-dev
  - remnux.packages.build-essential

remnux-python3-packages-thug-virtualenv:
  virtualenv.managed:
    - name: /opt/thug
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/{{ py3_version }}
    - pip_pkgs:
      - pip>=23.1.2
      - setuptools==67.7.2
      - wheel==0.38.4
      - "yara-python"
    - require:
      - sls: remnux.packages.{{ py3_dependency }}
      - sls: remnux.packages.virtualenv
      - sls: remnux.packages.{{ py3_dependency }}-dev

remnux-python3-packages-thug-venv-stpyv8-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ release }}
    - source: https://github.com/cloudflare/stpyv8/releases/download/v{{ version }}/{{ release }}
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-python3-packages-thug-venv-stpyv8-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/
    - source: /usr/local/src/remnux/files/{{ release }}
    - enforce_toplevel: False
    - watch:
      - file: remnux-python3-packages-thug-venv-stpyv8-source

remnux-python3-packages-thug-venv-stpyv8-pip:
  pip.installed:
    - name: /usr/local/src/remnux/{{ folder }}/{{ wheel }}
    - bin_env: /opt/thug/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.sudo
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-system-dev
      - sls: remnux.packages.libboost-dev
      - sls: remnux.packages.libboost-iostreams-dev
      - sls: remnux.python3-packages.setuptools
      - file: remnux-python3-packages-thug-venv-stpyv8-source
      - archive: remnux-python3-packages-thug-venv-stpyv8-archive

remnux-python3-packages-thug-git:
  git.latest:
    - name: https://github.com/buffer/thug
    - target: /usr/local/src/thug
    - branch: master
    - force_reset: True
    - force_checkout: True
    - force_fetch: True
    - require:
      - sls: remnux.packages.git

remnux-python3-packages-thug-packages:
  pip.installed:
    - name: thug
    - bin_env: /opt/thug/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
      - virtualenv: remnux-python3-packages-thug-virtualenv
      - sls: remnux.packages.libssl-dev
    - watch:
      - git: remnux-python3-packages-thug-git

remnux-python3-packages-thug-makedir:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - names:
      - /etc/thug
    - watch:
      - pip: remnux-python3-packages-thug-packages

remnux-python3-packages-thug-conf:
  cmd.run:
    - name: cp -R /usr/local/src/thug/thug/conf/* /etc/thug
    - watch:
      - file: remnux-python3-packages-thug-makedir

remnux-python3-packages-thug-symlink:
  file.symlink:
    - name: /usr/local/bin/thug
    - target: /opt/thug/bin/thug
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-thug-packages
