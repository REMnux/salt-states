# Name: Yara Rules
# Website: https://github.com/Yara-Rules/rules
# Description: Statically scan a file to identify common malicious capabilities.
# Category: Examine Static Properties: General
# Author: A group of IT security researchers: https://twitter.com/yararules
# License: GNU General Public License (GPL) v2: https://github.com/Yara-Rules/rules/blob/master/LICENSE
# Notes: To scan a file using these rules, you can use the wrapper around Yara: `yara-rules FILE`, where `FILE` is the path to the file you wish to scan.

include:
  - remnux.packages.git
  - remnux.packages.yara

remnux-tools-yara-rules:
  git.cloned:
    - name: https://github.com/Yara-Rules/rules.git
    - target: /usr/local/yara-rules
    - user: root
    - branch: master
    - require:
      - sls: remnux.packages.yara

remnux-tools-yara-rules-wrapper:
  file.managed:
    - name: /usr/local/bin/yara-rules
    - mode: 755
    - watch:
      - git: remnux-tools-yara-rules
    - contents:
      - '#!/bin/bash'
      - yara -w /usr/local/yara-rules/index.yar "${*}"
