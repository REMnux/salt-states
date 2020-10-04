# Name: CapTipper
# Website: https://github.com/omriher/CapTipper/tree/python3_support
# Description: Analyze and extract HTTP traffic contents and embedded artifacts.
# Category: Explore Network Interactions: Monitoring
# Author: Omri Herscovici
# License: GNU General Public License v3.0: https://github.com/omriher/CapTipper/blob/python3_support/LICENSE
# Notes: CapTipper.py

include:
  - remnux.packages.git
  - remnux.packages.python3

remnux-tools-captipper:
  git.latest:
    - name: https://github.com/omriher/CapTipper.git
    - rev: python3_support
    - target: /usr/local/CapTipper
    - user: root
    - require:
      - sls: remnux.packages.python3

remnux-tools-captipper-shebang:
  file.replace:
    - name: /usr/local/CapTipper/CapTipper.py
    - pattern: '#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: True
    - count: 1
    - watch:
      - git: remnux-tools-captipper

remnux-tools-captipper-permissions:
  file.managed:
    - name: /usr/local/CapTipper/CapTipper.py
    - mode: 755
    - watch:
      - file: remnux-tools-captipper-shebang

/usr/local/bin/CapTipper.py:
  file.symlink:
  - target: /usr/local/CapTipper/CapTipper.py
  - watch:
      - file: remnux-tools-captipper-permissions