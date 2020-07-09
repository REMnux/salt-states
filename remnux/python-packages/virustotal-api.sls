# Name: VirusTotal API
# Website: https://github.com/doomedraven/VirusTotalApi
# Description: Query and interact with VirusTotal using a command-line interface.
# Category: Gather and Analyze Data
# Author: doomedraven
# License: MIT License: https://github.com/doomedraven/VirusTotalApi/blob/master/LICENSE.md
# Notes: vt

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.git

remnux-python-package-virustotal-api:
  pip.installed:
    - name: git+https://github.com/doomedraven/VirusTotalApi
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git

