# Name: YARA-Forge Rules
# Website: https://yarahq.github.io/
# Description: Scan files with curated YARA rules from 45+ sources for malware family identification.
# Category: Examine Static Properties: General
# Author: Florian Roth and the YARA HQ community
# License: Various (see individual rules); Elastic rules excluded
# Notes: Run `yara-forge FILE` to identify malware families. Complements `yara-rules` which detects capabilities/behaviors.

include:
  - remnux.packages.yara

remnux-tools-yara-forge-source:
  file.managed:
    - name: /usr/local/src/remnux/files/yara-forge-rules-core.zip
    - source: https://github.com/YARAHQ/yara-forge/releases/download/20260201/yara-forge-rules-core.zip
    - source_hash: sha256=61b1af1ae1d276cc2bbe86118f93f2520786f9678ab4430b1590980dec585bcd
    - makedirs: True

remnux-tools-yara-forge-archive:
  archive.extracted:
    - name: /usr/local/yara-forge
    - source: /usr/local/src/remnux/files/yara-forge-rules-core.zip
    - enforce_toplevel: False
    - overwrite: True
    - require:
      - file: remnux-tools-yara-forge-source

remnux-tools-yara-forge-wrapper:
  file.managed:
    - name: /usr/local/bin/yara-forge
    - mode: 755
    - require:
      - archive: remnux-tools-yara-forge-archive
    - contents:
      - '#!/bin/bash'
      - 'yara -w /usr/local/yara-forge/packages/core/yara-rules-core.yar "${*}"'
