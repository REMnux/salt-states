# Name: Name-That-Hash
# Website: https://github.com/HashPals/Name-That-Hash
# Description: Identify dfferent types of hashes.
# Category: Examine Static Properties: General
# Author: Brandon / Bee: https://twitter.com/bee_sec_san
# License: GNU General Public License (GPL) v3.0: (https://github.com/HashPals/Name-That-Hash/blob/main/LICENSE)
# Notes: nth

include:
  - remnux.python3-packages.pip
  - remnux.packages.virtualenv

remnux-python3-packages-remove-name-that-hash:
  pip.removed:
    - name: name-that-hash
    - bin_env: /usr/bin/python3

remnux-python3-packages-name-that-hash-virtualenv:
  virtualenv.managed:
    - name: /opt/nth
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=23.1.2
      - setuptools==67.7.2
      - wheel==0.38.4
    - require:
      - sls: remnux.packages.virtualenv
      - sls: remnux.python3-packages.pip
      - pip: remnux-python3-packages-remove-name-that-hash

remnux-python3-packages-name-that-hash-install:
  pip.installed:
    - name: name-that-hash
    - bin_env: /opt/nth/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-name-that-hash-virtualenv

remnux-python3-packages-name-that-hash-symlink:
  file.symlink:
    - name: /usr/local/bin/nth
    - target: /opt/nth/bin/nth
    - makedirs: False
    - force: True
    - require:
      - pip: remnux-python3-packages-name-that-hash-install
