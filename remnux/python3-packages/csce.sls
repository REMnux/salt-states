# Name: Cobalt Strike Configuration Extractor (CSCE) and Parser
# Website: https://github.com/strozfriedberg/cobaltstrike-config-extractor
# Description: Analyze Cobalt Stike beacons.
# Category: Examine Static Properties: Deobfuscation
# Author: Aon / Stroz Friedberg
# License: Apache License 2.0: https://github.com/strozfriedberg/cobaltstrike-config-extractor/blob/master/LICENSE
# Notes: csce, list-cs-settings

{% set files = ['csce','list-cs-settings'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-csce-venv:
  virtualenv.managed:
    - name: /opt/csce
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-csce:
  pip.installed:
    - name: libcsce
    - bin_env: /opt/csce/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-csce-venv

{% for file in files %}
remnux-python3-package-csce-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/csce/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-csce
{% endfor %}
