# Name: base64dump
# Website: https://blog.didierstevens.com/2020/07/03/update-base64dump-py-version-0-0-12/
# Description: Locate and decode strings encoded in Base64 and other common encodings.
# Category: Examine Static Properties: Deobfuscation, Analyze Documents: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: base64dump.py

remnux-scripts-base64dump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/base64dump_V0_0_12.zip
    - source: https://didierstevens.com/files/software/base64dump_V0_0_12.zip
    - source_hash: 952a5009c945af350db0875e8f025e3b5d271fb54ac60be7569cfbd949dd7b77
    - makedirs: True

remnux-scripts-base64dump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/base64dump-0.0.12
    - source: /usr/local/src/remnux/files/base64dump_V0_0_12.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-base64dump-source

remnux-scripts-base64dump-binary:
  file.managed:
    - name: /usr/local/bin/base64dump.py
    - source: /usr/local/src/remnux/base64dump-0.0.12/base64dump.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-base64dump-archive
