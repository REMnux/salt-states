# Name: Name-That-Hash
# Website: https://github.com/HashPals/Name-That-Hash
# Description: Identify dfferent types of hashes.
# Category: Examine Static Properties: General
# Author: Brandon / Bee: https://x.com/bee_sec_san
# License: GNU General Public License (GPL) v3.0: (https://github.com/HashPals/Name-That-Hash/blob/main/LICENSE)
# Notes: nth

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-name-that-hash-virtualenv:
  virtualenv.managed:
    - name: /opt/nth
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib_metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

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
