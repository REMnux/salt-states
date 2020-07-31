# Name: ViperMonkey
# Website: https://www.decalage.info/en/vba_emulation
# Description: A VBA parser and emulation engine to analyze malicious macros.
# Category: Analyze Documents: Microsoft Office
# Author: Philippe Lagadec: https://twitter.com/decalage2
# License: Free, custom license: https://github.com/decalage2/ViperMonkey#license
# Notes: vmonkey

include:
  - remnux.packages.python-pip
  - remnux.packages.git
  - remnux.packages.virtualenv
  - remnux.packages.python3-pip

remnux-python-packages-vipermonkey-virtualenv:
  virtualenv.managed:
    - name: /opt/vipermonkey
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/python
    - pip_pkgs:
      - pip
      - setuptools
      - wheel
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.virtualenv

remnux-python-packages-vipermonkey-install:
  pip.installed:
    - editable: git+https://github.com/decalage2/ViperMonkey.git#egg=ViperMonkey
    - bin_env: /opt/vipermonkey/bin/python
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - virtualenv: remnux-python-packages-vipermonkey-virtualenv

remnux-python-packages-vipermonkey-symlink:
  file.symlink:
    - name: /usr/local/bin/vmonkey
    - target: /opt/vipermonkey/bin/vmonkey
    - force: true
    - require:
      - pip: remnux-python-packages-vipermonkey-install

