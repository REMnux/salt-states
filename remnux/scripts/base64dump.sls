# Name: base64dump
# Website: https://blog.didierstevens.com/2018/07/24/update-base64dump-py-version-0-0-11/
# Description: Locate and decode strings encoded in Base64 and other common encodings.
# Category: Artifact Extraction and Decoding
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: base64dump.py

remnux-scripts-base64dump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/base64dump_V0_0_11.zip
    - source: https://didierstevens.com/files/software/base64dump_V0_0_11.zip
    - source_hash: 2741f9c3fd7b0897a04f60c741d7125568c8355a82fcf0fd4bb80877ee7fb935
    - makedirs: True

remnux-scripts-base64dump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/base64dump-0.0.11
    - source: /usr/local/src/remnux/files/base64dump_V0_0_11.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-base64dump-source

remnux-scripts-base64dump-binary:
  file.managed:
    - name: /usr/local/bin/base64dump.py
    - source: /usr/local/src/remnux/base64dump-0.0.11/base64dump.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-base64dump-archive
