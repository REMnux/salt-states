# Name: strdeob.pl
# Website: https://github.com/REMnux/distro/blob/master/files/strdeob.pl
# Description: Locate and decode stack strings in executable files.
# Category: Examine Static Properties: Deobfuscation
# Author: TotalHash
# License: Free, unknown license
# Notes: 

include:
  - remnux.packages.perl
  - remnux.packages.binutils

remnux-scripts-strdeob-source:
  file.managed:
    - name: /usr/local/bin/strdeob.pl
    - source: https://github.com/REMnux/distro/raw/master/files/strdeob.pl
    - source_hash: sha256=b395c95be1a5bd0cdce258a8db4a81936aca7d1c9e9f5ca6f5a8c6a4c68eb9c5
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.binutils