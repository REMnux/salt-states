# Name: Detect-It-Easy
# Website: https://github.com/horsicq/Detect-It-Easy
# Description: Determine types of files and examine file properties.
# Category: Examine Static Properties: General
# Author: hors: https://x.com/horsicq
# License: MIT License: https://github.com/horsicq/Detect-It-Easy/blob/master/LICENSE
# Notes: GUI tool: `die`, command-line tool: `diec`.

include:
  - remnux.repos.remnux
  - remnux.packages.libglib2
  - remnux.packages.qtbase5-dev
  - remnux.packages.libqt5scripttools5

remnux-tools-detect-it-easy-install:
  pkg.installed:
    - name: detectiteasy
    - version: latest
    - upgrade: True
    - require:
      - pkgrepo: remnux-repo
      - sls: remnux.packages.libglib2
      - sls: remnux.packages.qtbase5-dev
      - sls: remnux.packages.libqt5scripttools5

remnux-tools-detect-it-easy-cleanup1:
  file.absent:
    - name: /usr/local/bin/die
    - require:
      - pkg: remnux-tools-detect-it-easy-install

remnux-tools-detect-it-easy-cleanup2:
  file.absent:
    - name: /usr/local/bin/diec
    - require:
      - pkg: remnux-tools-detect-it-easy-install
