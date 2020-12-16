# Name: zipdump.py
# Website: https://blog.didierstevens.com/2020/07/27/update-zipdump-py-version-0-0-20/
# Description: Analyze zip-compressed files.
# Category: Analyze Documents: Microsoft Office, Examine Static Properties: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

include:
  - remnux.packages.python3

remnux-scripts-zipdump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/zipdump_v0_0_20.zip
    - source: https://didierstevens.com/files/software/zipdump_v0_0_20.zip
    - source_hash: AC626299A6048FA4A7E8BE2993411870F77B4B89F647B6C4264E0CC22E180999
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-zipdump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/zipdump_v0_0_20
    - source: /usr/local/src/remnux/files/zipdump_v0_0_20.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-zipdump-source

remnux-scripts-zipdump-shebang:
  file.replace:
    - name: /usr/local/src/remnux/zipdump_v0_0_20/zipdump.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - archive: remnux-scripts-zipdump-archive

remnux-scripts-zipdump-binary:
  file.managed:
    - name: /usr/local/bin/zipdump.py
    - source: /usr/local/src/remnux/zipdump_v0_0_20/zipdump.py
    - mode: 755
    - watch:
      - file: remnux-scripts-zipdump-shebang
