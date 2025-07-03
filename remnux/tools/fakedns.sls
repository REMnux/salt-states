# Name: fakedns
# Website: https://github.com/SocialExploits/fakedns/blob/main/fakedns.py
# Description: Respond to DNS queries with the specified IP address.
# Category: Explore Network Interactions: Services
# Author: Mike Murr: mike@socialexploits.com, https://socialexploits.com
# License: Apache License 2.0
# Notes: Use the `-h` parameter to display usage and help details.

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-netifaces

remnux-tools-fakedns-venv:
  virtualenv.managed:
    - name: /opt/fakedns
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-tools-fakedns:
  file.managed:
    - name: /opt/fakedns/bin/fakedns.py
    - source: https://github.com/SocialExploits/fakedns/raw/main/fakedns.py
    - source_hash: sha256=6c0f814c15f2e5ec1d3e11a341b3bd53bf2b9c464ceaa5fd88d3d3cdca3d1ff2
    - mode: 755
    - makedirs: True
    - require:
        - virtualenv: remnux-tools-fakedns-venv
        - sls: remnux.packages.python3-netifaces

remnux-tools-fakedns-symlink:
  file.symlink:
    - name: /usr/local/bin/fakedns.py
    - target: /opt/fakedns/bin/fakedns.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-tools-fakedns

remnux-tools-fakedns-shebang:
  file.replace:
    - name: /opt/fakedns/bin/fakedns.py
    - pattern: '#!/usr/bin/env python3\n'
    - repl: '#!/opt/fakedns/bin/python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-tools-fakedns-symlink
