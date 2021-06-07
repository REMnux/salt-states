# Name: Detect-It-Easy
# Website: https://github.com/horsicq/Detect-It-Easy
# Description: Determine types of files and examine file properties. Available in the REMnux distro based on Ubuntu 20.04 (Focal); not available on Ubuntu 18.04 (Bionic).
# Category: Examine Static Properties: General
# Author: hors: https://twitter.com/horsicq
# License: MIT License: https://github.com/horsicq/Detect-It-Easy/blob/master/LICENSE
# Notes: GUI tool: `die`, command-line tool: `diec`.

{%- if grains['oscodename'] == "focal" %}

include:
  - remnux.packages.libglib2

remnux-tools-detect-it-easy-source:
  file.managed:
    - name: /usr/local/src/remnux/files/die_lin64_portable_3.01.tar.gz
    - source: https://github.com/horsicq/DIE-engine/releases/download/3.01/die_lin64_portable_3.01.tar.gz
    - source_hash: sha256=65e8881ce8bc14d376d909976f739e0cd9ca0ad846906518e0297dbb56f62662
    - makedirs: true
    - require:
      - sls: remnux.packages.libglib2

remnux-tools-detect-it-easy-archive:
  archive.extracted:
    - name: /usr/local
    - source: /usr/local/src/remnux/files/die_lin64_portable_3.01.tar.gz
    - enforce_toplevel: false
    - watch:
      - file: remnux-tools-detect-it-easy-source

remnux-tools-detect-it-easy-wrapper1:
  file.managed:
    - name: /usr/local/bin/die
    - mode: 755
    - replace: False
    - watch:
        - archive: remnux-tools-detect-it-easy-archive
    - contents:
      - '#!/bin/bash'
      - LD_LIBRARY_PATH=/usr/local/die_lin64_portable/base:$LD_LIBRARY_PATH /usr/local/die_lin64_portable/base/die "$@"

remnux-tools-detect-it-easy-wrapper2:
  file.managed:
    - name: /usr/local/bin/diec
    - mode: 755
    - replace: False
    - watch:
        - archive: remnux-tools-detect-it-easy-archive
    - contents:
      - '#!/bin/bash'
      - LD_LIBRARY_PATH=/usr/local/die_lin64_portable/base:$LD_LIBRARY_PATH /usr/local/die_lin64_portable/base/diec "$@"

{%- elif grains['oscodename'] == "bionic" %}

remnux-tools-detect-it-easy-source:
  test.nop

{%- endif %}