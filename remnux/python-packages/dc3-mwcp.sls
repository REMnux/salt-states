# Name: DC3-MWCP
# Website: https://github.com/Defense-Cyber-Crime-Center/DC3-MWCP
# Description: Python3 framework for parsing configuration information from malware
# Category: Statically examine PE files: Investigate
# Author: Defense Cyber Crime Center - United States Government
# License: https://github.com/Defense-Cyber-Crime-Center/DC3-MWCP/blob/master/LICENSE.txt
# Notes: mwcp

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-dc3-mwcp-install:
  pip.installed:
    - name: mwcp
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
