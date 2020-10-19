# Name: Automater
# Website: http://www.tekdefense.com/automater/
# Description: Gather OSINT data about IPs, domains, and hashes.
# Category: Gather and Analyze Data
# Author: 1aN0rmus: https://twitter.com/TekDefense
# License: MIT License: https://github.com/1aN0rmus/TekDefense-Automater/blob/master/LICENSE
# Notes: Automater.py

include:
  - remnux.packages.git
  - remnux.python-packages.urllib3
  - remnux.python-packages.certifi

remnux-tools-automater:
  git.cloned:
    - name: https://github.com/1aN0rmus/TekDefense-Automater
    - target: /usr/local/automater
    - user: root
    - branch: master

remnux-tools-automater-binary:
  file.managed:
    - replace: False
    - name: /usr/local/automater/Automater.py
    - mode: 755
    - watch:
      - git: remnux-tools-automater
      - sls: remnux.python-packages.urllib3
      - sls: remnux.python-packages.certifi

remnux-tools-automater-symlink:
  file.symlink:
    - name: /usr/local/bin/Automater.py
    - target: /usr/local/automater/Automater.py
    - mode: 755

remnux-tools-automater-shebang:
  file.replace:
    - name: /usr/local/bin/Automater.py
    - pattern: '#!/usr/bin/python\n'
    - repl: '#!/usr/bin/env python2\n'
    - count: 1
    - require:
      - file: remnux-tools-automater-binary
