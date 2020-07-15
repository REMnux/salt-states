# Name: zipdump.py
# Website: https://blog.didierstevens.com/2020/04/30/update-zipdump-py-version-0-0-19/
# Description: Analyze zip-compressed files.
# Category: Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

remnux-scripts-zipdump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/zipdump_v0_0_19.zip
    - source: https://didierstevens.com/files/software/zipdump_v0_0_19.zip
    - source_hash: EB38D57E63B12EFAC531B4F0BA866BF47CAEC7F64E0C3CCF4557476FFF1C6226
    - makedirs: True

remnux-scripts-zipdump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/zipdump_v0_0_19
    - source: /usr/local/src/remnux/files/zipdump_v0_0_19.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-zipdump-source

remnux-scripts-zipdump-shebang:
  file.replace:
    - name: /usr/local/src/remnux/zipdump_v0_0_19/zipdump.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - archive: remnux-scripts-zipdump-archive

remnux-scripts-zipdump-binary:
  file.managed:
    - name: /usr/local/bin/zipdump.py
    - source: /usr/local/src/remnux/zipdump_v0_0_19/zipdump.py
    - mode: 755
    - watch:
      - file: remnux-scripts-zipdump-shebang
