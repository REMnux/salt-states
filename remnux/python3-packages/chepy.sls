# Name: Chepy
# Website: https://github.com/securisec/chepy
# Description: Decode and otherwise analyze data using this command-line tool and Python library.
# Category: Examine Static Properties: Deobfuscation
# Author: securisec: https://x.com/securisec
# License: GNU General Public License (GPL) v3: https://github.com/securisec/chepy/blob/master/LICENSE
# Notes: chepy

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev

remnux-python3-packages-chepy-venv:
  virtualenv.managed:
    - name: /opt/chepy
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip<25.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - pycryptodome
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.libxml2-dev
      - sls: remnux.packages.libxslt1-dev

remnux-python3-packages-chepy:
  pip.installed:
    - name: chepy
    - bin_env: /opt/chepy/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-chepy-venv

remnux-python3-packages-chepy-extras:
  pip.installed:
    - name: chepy[extras]
    - bin_env: /opt/chepy/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-chepy-venv

remnux-python3-packages-chepy-symlink:
  file.symlink:
    - name: /usr/local/bin/chepy
    - target: /opt/chepy/bin/chepy
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-chepy
