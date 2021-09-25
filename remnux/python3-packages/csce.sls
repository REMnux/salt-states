# Name: Cobalt Strike Configuration Extractor (CSCE) and Parser
# Website: https://github.com/strozfriedberg/cobaltstrike-config-extractor
# Description: Analyze Cobalt Stike beacons.
# Category: Examine Static Properties: Deobfuscation
# Author: Aon / Stroz Friedberg
# License: Apache License 2.0: https://github.com/strozfriedberg/cobaltstrike-config-extractor/blob/master/LICENSE
# Notes: csce, list-cs-settings

include:
  - remnux.python3-packages.pip

remnux-python3-packages-csce-install:
  pip.installed:
    - name: libcsce
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
