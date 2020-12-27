# Name: base64dump
# Website: https://blog.didierstevens.com/2020/07/03/update-base64dump-py-version-0-0-12/
# Description: Locate and decode strings encoded in Base64 and other common encodings.
# Category: Examine Static Properties: Deobfuscation, Analyze Documents: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: base64dump.py

include:
  - remnux.packages.python2

remnux-scripts-base64dump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/base64dump_V0_0_13.zip
    - source: https://didierstevens.com/files/software/base64dump_V0_0_13.zip
    - source_hash: EE6527B4F558439916D9854980D6980EECA9F130F37BBF4034453ABBD8BF3260
    - makedirs: True
    - require:
      - sls: remnux.packages.python2

remnux-scripts-base64dump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/base64dump-0.0.13
    - source: /usr/local/src/remnux/files/base64dump_V0_0_13.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-base64dump-source

remnux-scripts-base64dump-binary:
  file.managed:
    - name: /usr/local/bin/base64dump.py
    - source: /usr/local/src/remnux/base64dump-0.0.13/base64dump.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-base64dump-archive

remnux-scripts-base64dump-formatting:
  file.replace:
    - name: /usr/local/bin/base64dump.py
    - pattern: '\r'
    - repl: ''
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-base64dump-binary

remnux-scripts-base64dump-shebang:
  file.replace:
    - name: /usr/local/bin/base64dump.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python2\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-base64dump-formatting