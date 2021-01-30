# Name: Name-That-Hash
# Website: https://github.com/HashPals/Name-That-Hash
# Description: Identify dfferent types of hashes. Available in the REMnux distro based on Ubuntu 20.04 (Focal); not available on Ubuntu 18.04 (Bionic).
# Category: Examine Static Properties: General
# Author: Brandon / Bee: https://twitter.com/bee_sec_san
# License: Free, unknown license
# Notes: nth

include:
  - remnux.packages.python3-pip

{%- if grains['oscodename'] == "focal" %}

remnux-python3-name-that-hash-install:
  pip.installed:
    - name: name-that-hash
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip

{%- endif %}