# Name: Name-That-Hash
# Website: https://github.com/HashPals/Name-That-Hash
# Description: Identify dfferent types of hashes. Available in the REMnux distro based on Ubuntu 20.04 (Focal); not available on Ubuntu 18.04 (Bionic).
# Category: Examine Static Properties: General
# Author: Brandon / Bee: https://twitter.com/bee_sec_san
# License: GNU General Public License (GPL) v3.0: (https://github.com/HashPals/Name-That-Hash/blob/main/LICENSE)
# Notes: nth

{%- if grains['oscodename'] == "focal" %}

include:
  - remnux.python3-packages.pip

remnux-python3-packages-name-that-hash-install:
  pip.installed:
    - name: name-that-hash
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip

{%- elif grains['oscodename'] == "bionic" %}

remnux-python3-packages-name-that-hash-install:
  test.nop

{%- endif %}
