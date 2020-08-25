# Name: malwoverview
# Website: https://github.com/alexandreborges/malwoverview
# Description: Query public repositories of malware data (e.g., VirusTotal, HybridAnalysis).
# Category: Gather and Analyze Data
# Author: Alexandre Borges
# License: GNU General Public License v3: https://github.com/alexandreborges/malwoverview/blob/master/LICENSE
# Notes: malwoverview.py, add API keys to ~/.malwapi.conf

{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}       

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.git
  - remnux.config.user
  - remnux.python-packages.pytest

remnux-python-packages-malwoverview-install:
  pip.installed:
    - name: git+https://github.com/alexandreborges/malwoverview.git
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git
      - sls: remnux.python-packages.pytest

remnux-python-packages-malwoverview-config-file:
  file.managed:
    - name: {{ home }}/.malwapi.conf
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: False
    - require:
      - user: remnux-user-{{ user }}
      - pip: remnux-python-packages-malwoverview-install