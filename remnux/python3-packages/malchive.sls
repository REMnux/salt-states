# Name: Malchive
# Website: https://github.com/MITRECND/malchive
# Description: Perform static analysis of various aspects of malicious code.
# Category: Statically Analyze Code: PE Files, Examine Static Properties: Deobfuscation
# Author: The MITRE Corporation, https://github.com/MITRECND/malchive/graphs/contributors
# License: Apache License 2.0: https://github.com/MITRECND/malchive/blob/main/LICENSE
# Notes: Malchive command-line tools start with the prefix `malutil-`. See [utilities documentation](https://github.com/MITRECND/malchive/wiki/Utilities) for details.

include:
  - remnux.python3-packages.pip
  - remnux.packages.git
  - remnux.python3-packages.cffi

remnux-python3-packages-malchive:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: git+https://github.com/MITRECND/malchive.git@main
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.git
      - sls: remnux.python3-packages.cffi
