include:
  - remnux.packages.libboost-regex-dev
  - remnux.packages.libboost-system-dev
  - remnux.packages.libboost-filesystem-dev
  - remnux.packages.libboost-program-options-dev

remnux-tools-manalyze-source:
  file.managed:
    - name: /usr/local/src/remnux/files/manalyze-0.9.tgz
    - source: https://github.com/REMnux/distro/raw/master/files/manalyze-0.9-focal.tgz
    - source_hash: sha256=6fd34217764a4fad7590ed643963ab3c5a8ed3f60a2c3d449e6fca5fd86095f3
    - makedirs: true
    - require:
      - sls: remnux.packages.libboost-regex-dev
      - sls: remnux.packages.libboost-system-dev
      - sls: remnux.packages.libboost-filesystem-dev
      - sls: remnux.packages.libboost-program-options-dev

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
