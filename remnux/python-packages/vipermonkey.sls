# Name: ViperMonkey
# Website: https://www.decalage.info/en/vba_emulation
# Description: A VBA parser and emulation engine to analyze malicious macros.
# Category: Analyze Documents: Microsoft Office
# Author: Philippe Lagadec: https://twitter.com/decalage2
# License: Free, custom license: https://github.com/decalage2/ViperMonkey#license
# Notes: vmonkey

{%- if grains['oscodename'] == "focal" %}

include:
  - remnux.packages.python2-pip
  - remnux.packages.git
  - remnux.packages.virtualenv
  - remnux.packages.python3-pip
  - remnux.packages.python2-dev

{%- else %}

include:
  - remnux.packages.python2-pip
  - remnux.packages.git
  - remnux.packages.virtualenv
  - remnux.packages.python3-pip

{%- endif %}

remnux-python-packages-vipermonkey-virtualenv:
  virtualenv.managed:
    - name: /opt/vipermonkey
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/python2
    - pip_pkgs:
      - pip
      - setuptools
      - wheel
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.virtualenv

{%- if grains['oscodename'] == "focal" %}

remnux-python-packages-vipermonkey-unidecode:
  pip.installed:
    - name: unidecode==1.2.0
    - bin_env: /opt/vipermonkey/bin/python
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.python2-dev

remnux-python-packages-vipermonkey-install:
  pip.installed:
    - name: git+https://github.com/decalage2/ViperMonkey.git
    - bin_env: /opt/vipermonkey/bin/python
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.python2-dev
      - pip: remnux-python-packages-vipermonkey-unidecode
      - virtualenv: remnux-python-packages-vipermonkey-virtualenv

{%- else %}

remnux-python-packages-vipermonkey-unidecode:
  pip.installed:
    - name: unidecode==1.2.0
    - bin_env: /opt/vipermonkey/bin/python
    - require:
      - sls: remnux.packages.python2-pip

remnux-python-packages-vipermonkey-install:
  pip.installed:
    - name: git+https://github.com/decalage2/ViperMonkey.git
    - bin_env: /opt/vipermonkey/bin/python
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python2-pip
      - pip: remnux-python-packages-vipermonkey-unidecode
      - virtualenv: remnux-python-packages-vipermonkey-virtualenv

{%- endif %}

remnux-python-packages-vipermonkey-symlink:
  file.symlink:
    - name: /usr/local/bin/vmonkey
    - target: /opt/vipermonkey/bin/vmonkey
    - force: true
    - require:
      - pip: remnux-python-packages-vipermonkey-install

