# Name: 1768.py
# Website: https://blog.didierstevens.com/2021/05/22/update-1768-py-version-0-0-6/
# Description: Analyze Cobalt Stike beacons.
# Category: Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: For an overview of this tool, see the [Quick Tip](https://isc.sans.edu/forums/diary/Quick+Tip+Cobalt+Strike+Beacon+Analysis/26818) article.

include:
  - remnux.python3-packages.pefile

remnux-scripts-1768-source:
  file.managed:
    - name: /usr/local/src/remnux/files/1768_v0_0_7.zip
    - source: https://didierstevens.com/files/software/1768_v0_0_7.zip
    - source_hash: B417790451681643B2269AC516A99F3CEE9F7F374AB529FD53D5702A70F79409
    - makedirs: True
    - require:
      - sls: remnux.python3-packages.pefile

remnux-scripts-1768-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/1768_v0_0_7
    - source: /usr/local/src/remnux/files/1768_v0_0_7.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-scripts-1768-source

remnux-scripts-1768-binary:
  file.managed:
    - name: /usr/local/bin/1768.py
    - source: /usr/local/src/remnux/1768_v0_0_7/1768.py
    - mode: 755
    - require:
      - archive: remnux-scripts-1768-archive

remnux-scripts-1768-shebang:
  file.replace:
    - name: /usr/local/bin/1768.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-1768-binary