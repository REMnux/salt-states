# Name: CapTipper
# Website: https://github.com/omriher/CapTipper/tree/python3_support
# Description: Analyze HTTP traffic and extract embedded artifacts.
# Category: Explore Network Interactions: Monitoring
# Author: Omri Herscovici: https://twitter.com/omriher
# License: GNU General Public License v3.0: https://github.com/omriher/CapTipper/blob/python3_support/LICENSE
# Notes: CapTipper.py

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.git

remnux-tools-captipper-venv:
  virtualenv.managed:
    - name: /opt/captipper
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-tools-captipper:
  git.latest:
    - name: https://github.com/omriher/CapTipper.git
    - rev: python3_support
    - target: /opt/captipper/bin/captipper_git
    - force_reset: True
    - force_checkout: True
    - force_fetch: True
    - user: root
    - require:
      - virtualenv: remnux-tools-captipper-venv

remnux-tools-captipper-copy:
  cmd.run:
    - name: cp -rf /opt/captipper/bin/captipper_git/* /opt/captipper/bin/
    - shell: /bin/bash
    - require:
      - git: remnux-tools-captipper

remnux-tools-captipper-delete-git:
  file.absent:
    - name: /opt/captipper/bin/captipper_git
    - require:
      - cmd: remnux-tools-captipper-copy

remnux-tools-captipper-permissions:
  file.managed:
    - name: /opt/captipper/bin/CapTipper.py
    - mode: 755
    - watch:
      - git: remnux-tools-captipper
    - require:
      - file: remnux-tools-captipper-delete-git

remnux-tools-captipper-symlink:
  file.symlink:
    - name: /usr/local/bin/CapTipper.py
    - target: /opt/captipper/bin/CapTipper.py
    - force: True
    - makedirs: False
    - require:
      - git: remnux-tools-captipper

remnux-tools-captipper-shebang:
  file.replace:
    - name: /opt/captipper/bin/CapTipper.py
    - pattern: '#!/usr/bin/env python3\n'
    - repl: '#!/opt/captipper/bin/python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-tools-captipper-symlink
