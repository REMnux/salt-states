# Name: malwoverview
# Website: https://github.com/digitalsleuth/malwoverview
# Description: Python 3 tool to query VirusTotal, HybridAnalysis et al.
# Category: Examine file properties and contents: Hashes
# Author: Alexandre Borges
# License: https://github.com/digitalsleuth/malwoverview/blob/master/LICENSE
# Notes: malwoverview.py, add API keys to ~/.malwapi.conf

{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}

{% if user != "root" %}

{% set home = "/home/" + user %}

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.git

remnux-python-packages-malwoverview-install:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/malwoverview.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git

remnux-python-packages-malwoverview-config-file:
  file.managed:
    - name: {{ home }}/.malwapi.conf
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: False
    - require:
      - pip: remnux-python-packages-malwoverview-install

{% endif %}
