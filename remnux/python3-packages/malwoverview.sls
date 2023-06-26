# Name: malwoverview
# Website: https://github.com/alexandreborges/malwoverview
# Description: Query public repositories of malware data (e.g., VirusTotal, HybridAnalysis).
# Category: Gather and Analyze Data
# Author: Alexandre Borges
# License: GNU General Public License v3: https://github.com/alexandreborges/malwoverview/blob/master/LICENSE
# Notes: malwoverview.py, add API keys to ~/.malwapi.conf
{%- if grains['oscodename'] == "bionic" %}
  {%- set python3_version="python3.6" %}
{%- else %}
  {%- set python3_version="python3.8" %}
{% endif %}
{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}       

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.python3-packages.pip
  - remnux.packages.git
  - remnux.config.user
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-venv
  - remnux.packages.virtualenv
  - remnux.packages.build-essential

remnux-python3-packages-malwoverview-virtualenv:
  virtualenv.managed:
    - name: /opt/malwoverview
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/python3
    - pip_pkgs:
      - pip
      - setuptools
      - wheel
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.python3-venv
      - sls: remnux.packages.virtualenv

remnux-python3-packages-malwoverview-install:
  pip.installed:
    - name: malwoverview
    - bin_env: /opt/malwoverview/bin/python3
    - upgrade: True
    - user: root
    - require:
      - sls: remnux.python3-packages.pip
      - virtualenv: remnux-python3-packages-malwoverview-virtualenv
      - sls: remnux.packages.git
      - sls: remnux.config.user

remnux-python3-packages-malwoverview-config-file:
  file.managed:
    - name: {{ home }}/.malwapi.conf
    - source: /opt/malwoverview/lib/{{ python3_version }}/site-packages/root/.malwapi.conf
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: False
    - require:
      - sls: remnux.config.user
      - user: remnux-user-{{ user }}
      - pip: remnux-python3-packages-malwoverview-install
      - virtualenv: remnux-python3-packages-malwoverview-virtualenv

remnux-python3-packages-malwoverview-symlink:
  file.symlink:
    - name: /usr/local/bin/malwoverview.py
    - target: /opt/malwoverview/bin/malwoverview.py
    - force: true
    - require:
      - pip: remnux-python3-packages-malwoverview-install
