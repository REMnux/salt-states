# Name: base64dump
# Website: https://blog.didierstevens.com/2020/07/03/update-base64dump-py-version-0-0-12/
# Description: Locate and decode strings encoded in Base64 and other common encodings.
# Category: Examine Static Properties: Deobfuscation, Analyze Documents: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: base64dump.py

include:
  - remnux.packages.python3

remnux-scripts-base64dump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/base64dump_V0_0_14.zip
    - source: https://didierstevens.com/files/software/base64dump_V0_0_14.zip
    - source_hash: sha256=2F58F630D9B12D2B70CECF35728096A247890808E44DAB9C94400A073D5E29BF
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-base64dump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/base64dump_V0_0_14
    - source: /usr/local/src/remnux/files/base64dump_V0_0_14.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-scripts-base64dump-source

remnux-scripts-base64dump-binary:
  file.managed:
    - name: /usr/local/bin/base64dump.py
    - source: /usr/local/src/remnux/base64dump_V0_0_14/base64dump.py
    - mode: 755
    - require:
      - archive: remnux-scripts-base64dump-archive

remnux-scripts-base64dump-shebang:
  file.replace:
    - name: /usr/local/bin/base64dump.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-base64dump-binary