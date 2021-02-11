# Name: VirusTotal API
# Website: https://github.com/doomedraven/VirusTotalApi
# Description: Query and interact with VirusTotal using a command-line interface.
# Category: Gather and Analyze Data
# Author: doomedraven
# License: MIT License: https://github.com/doomedraven/VirusTotalApi/blob/master/LICENSE.md
# Notes: vt

include:
  - remnux.python3-packages.pip
  - remnux.packages.git

remnux-python3-package-virustotal-api:
  pip.installed:
    - name: git+https://github.com/doomedraven/VirusTotalApi
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.git

