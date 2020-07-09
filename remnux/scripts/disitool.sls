# Name: disitool
# Website: https://blog.didierstevens.com/programs/disitool/
# Description: Manipulate embedded digital signatures.
# Category: Examine Static Properties: General
# Author: Didier Stevens
# License: Public Domain
# Notes: disitool.py

include:
  - remnux.python-packages.pefile

remnux-scripts-disitool-source:
  file.managed:
    - name: /usr/local/src/remnux/files/disitool_v0_3.zip
    - source: https://www.didierstevens.com/files/software/disitool_v0_3.zip
    - source_hash: sha256=AEF923F49E53C7C2194058F34A73B293D21448DEB7E2112819FC1B3B450347B8
    - makedirs: True

remnux-scripts-disitool-archive:
  archive.extracted:
    - name: /usr/local/bin/
    - source: /usr/local/src/remnux/files/disitool_v0_3.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-disitool-source

/usr/local/bin/disitool.py:
  file.managed:
    - mode: 755
    - watch:
      - archive: remnux-scripts-disitool-archive


