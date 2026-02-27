# Name: Malcat Lite
# Website: https://malcat.fr
# Description: Analyze binary files using a hex editor, disassembler, and file dissector.
# Category: Examine Static Properties: General
# Author: https://malcat.fr, https://x.com/malcat4ever
# License: Proprietary (Lite edition free): https://malcat.fr/index.html
# Notes: The Lite version of the tool may not be used in a professional environment per its license.

{% set file = 'malcat_ubuntu24_lite.zip' %}
{% set hash = 'd349bca923b78bc96d4021bf4874de08dadbe7440fcdcb1e0de17b5c28332a17' %}

include:
  - remnux.packages.libgtk-3-0
  - remnux.packages.libsm6
  - remnux.packages.openssl
  - remnux.packages.python3-virtualenv

remnux-tools-malcat-cleanup:
  file.absent:
    - name: /usr/local/src/remnux/files/malcat_ubuntu2413_lite.zip

remnux-tools-malcat-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ file }}
    - source: https://malcat.fr/latest/{{ file }}
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - require:
      - sls: remnux.packages.libgtk-3-0
      - sls: remnux.packages.libsm6
      - sls: remnux.packages.openssl

remnux-tools-malcat-archive:
  archive.extracted:
    - name: /opt/malcat
    - source: /usr/local/src/remnux/files/{{ file }}
    - enforce_toplevel: False
    - force: True
    - watch:
      - file: remnux-tools-malcat-source

remnux-tools-malcat-venv:
  virtualenv.managed:
    - name: /opt/malcat-deps
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-tools-malcat-pip-deps:
  pip.installed:
    - requirements: /opt/malcat/requirements.txt
    - bin_env: /opt/malcat-deps/bin/python3
    - require:
      - archive: remnux-tools-malcat-archive
      - virtualenv: remnux-tools-malcat-venv

remnux-tools-malcat-wrapper:
  file.managed:
    - name: /usr/local/bin/malcat
    - mode: 755
    - require:
      - pip: remnux-tools-malcat-pip-deps
    - contents:
      - '#!/bin/bash'
      - 'export PYTHONPATH=/opt/malcat-deps/lib/python3.12/site-packages'
      - 'exec /opt/malcat/bin/malcat "$@"'
