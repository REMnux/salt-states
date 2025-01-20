# Name: Balbuzard
# Website: https://github.com/digitalsleuth/balbuzard
# Description: Extract and deobfuscate patterns from suspicious files.
# Category: Examine Static Properties: Deobfuscation
# Author: Philippe Lagadec / Corey Forman (digitalsleuth)
# License: Free, custom license: https://github.com/digitalsleuth/balbuzard
# Notes: balbuzard, bbcrack, bbharvest, bbtrans

{% set tools = ['balbuzard','bbcrack','bbharvest','bbtrans'] %}

include:
  - remnux.packages.virtualenv

remnux-python3-packages-balbuzard-virtualenv:
  virtualenv.managed:
    - name: /opt/balbuzard
    - python: /usr/bin/python3
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=23.1.2
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.virtualenv

remnux-python3-packages-balbuzard-install:
  pip.installed:
    - name: balbuzard-3
    - bin_env: /opt/balbuzard/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-balbuzard-virtualenv

{% for tool in tools %}
remnux-python3-packages-dissect-{{ tool }}-symlink:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/balbuzard/bin/{{ tool }}
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-balbuzard-install
{% endfor %}
