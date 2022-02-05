# Name: Detect-It-Easy
# Website: https://github.com/horsicq/Detect-It-Easy
# Description: Determine types of files and examine file properties.
# Category: Examine Static Properties: General
# Author: hors: https://twitter.com/horsicq
# License: MIT License: https://github.com/horsicq/Detect-It-Easy/blob/master/LICENSE
# Notes: GUI tool: `die`, command-line tool: `diec`.

{%- if grains['oscodename'] == "focal" %}

include:
  - remnux.packages.libglib2
  - remnux.packages.qt5-default
  - remnux.packages.libqt5scripttools5

remnux-tools-detect-it-easy-source:
  file.managed:
    - name: /usr/local/src/remnux/files/die_3.04_Ubuntu_20.04_amd64.deb
    - source: https://github.com/horsicq/DIE-engine/releases/download/3.04/die_3.04_Ubuntu_20.04_amd64.deb
    - source_hash: sha256=12b76ea8e4a871ecb3b27015f6733c383cc460f4e01451949cf44bb2e2feb497
    - makedirs: true

remnux-tools-detect-it-easy-cleanup1:
  file.absent:
    - name: /usr/local/bin/die
    - require:
      - file: remnux-tools-detect-it-easy-source

remnux-tools-detect-it-easy-cleanup2:
  file.absent:
    - name: /usr/local/bin/diec
    - require:
      - file: remnux-tools-detect-it-easy-cleanup1

remnux-tools-detect-it-easy-install:
  pkg.installed:
    - sources:
      - detectiteasy: /usr/local/src/remnux/files/die_3.04_Ubuntu_20.04_amd64.deb
    - require:
      - file: remnux-tools-detect-it-easy-cleanup2
      - sls: remnux.packages.libglib2
      - sls: remnux.packages.qt5-default
      - sls: remnux.packages.libqt5scripttools5

{%- elif grains['oscodename'] == "bionic" %}

remnux-tools-detect-it-easy-source:
  test.nop

{%- endif %}