# Name: Manalyze
# Website: https://github.com/JusticeRage/Manalyze
# Description: Perform static analysis of suspicious PE files.
# Category: Examine Static Properties: PE Files
# Author: Ivan Kwiatkowski: https://twitter.com/JusticeRage
# License: GNU General Public License (GPL) v3: https://github.com/zrax/pycdc/blob/master/LICENSE
# Notes: Run "manalyze" to invoke the tool. To update the tool's Yara rules to include ClamAV, run "sudo /usr/local/manalyze/yara_rules/update_clamav_signatures.py".

include:
  - remnux.packages.libboost-regex
  - remnux.packages.libboost-system
  - remnux.packages.libboost-filesystem
  - remnux.packages.libboost-program-options

remnux-tools-manalyze-source:
  file.managed:
    - name: /usr/local/src/remnux/files/manalyze-0.9.tgz
    - source: https://github.com/REMnux/distro/raw/master/files/manalyze-0.9.tgz
    - source_hash: sha256=8a29949fbd4fd536f4822aec477861e730336a034af9f61376ecfce7dae7bfaa
    - makedirs: true
    - require:
      - sls: remnux.packages.libboost-regex
      - sls: remnux.packages.libboost-system
      - sls: remnux.packages.libboost-filesystem
      - sls: remnux.packages.libboost-program-options

remnux-tools-manalyze-archive:
  archive.extracted:
    - name: /usr/local
    - source: /usr/local/src/remnux/files/manalyze-0.9.tgz
    - enforce_toplevel: false
    - watch:
      - file: remnux-tools-manalyze-source

remnux-tools-manalyze-wrapper:
  file.managed:
    - name: /usr/local/bin/manalyze
    - mode: 755
    - replace: False
    - watch:
        - archive: remnux-tools-manalyze-archive
    - contents:
      - '#!/bin/bash'
      - LD_LIBRARY_PATH=/usr/local/manalyze:$LD_LIBRARY_PATH /usr/local/manalyze/manalyze ${*}