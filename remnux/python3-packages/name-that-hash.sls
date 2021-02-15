# Name: Name-That-Hash
# Website: https://github.com/HashPals/Name-That-Hash
# Description: Identify dfferent types of hashes.
# Category: Examine Static Properties: General
# Author: Brandon / Bee: https://twitter.com/bee_sec_san
# License: GNU General Public License (GPL) v3.0: (https://github.com/HashPals/Name-That-Hash/blob/main/LICENSE)
# Notes: nth

include:
  - remnux.python3-packages.pip

remnux-python3-packages-name-that-hash-install:
  pip.installed:
    - name: name-that-hash==1.1.0
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip