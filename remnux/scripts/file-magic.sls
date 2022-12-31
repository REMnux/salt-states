# Name: file-magic.py
# Website: https://blog.didierstevens.com/2022/12/23/update-file-magic-py-version-0-0-5/
# Description: Identify file type using "magic" numbers.
# Category: Examine Static Properties: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes:

include:
  - remnux.packages.python3
  - remnux.packages.python3-magic

remnux-scripts-file-magic-source:
  file.managed:
    - name: /usr/local/src/remnux/files/file-magic_V0_0_5.zip
    - source: https://didierstevens.com/files/software/file-magic_V0_0_5.zip
    - source_hash: 876F9AC31E1EC395EB93922AA2A7EFA027534F7343500648FE0A036021C7F1B9
    - makedirs: True
    - require:
      - sls: remnux.packages.python3
      - sls: remnux.packages.python3-magic

remnux-scripts-file-magic-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/file-magic_V0_0_5
    - source: /usr/local/src/remnux/files/file-magic_V0_0_5.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-file-magic-source

remnux-scripts-file-magic-shebang:
  file.replace:
    - name: /usr/local/src/remnux/file-magic_V0_0_5/file-magic.py
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - backup: false
    - count: 1
    - require:
      - archive: remnux-scripts-file-magic-archive

remnux-scripts-file-magic-binary:
  file.managed:
    - name: /usr/local/bin/file-magic.py
    - source: /usr/local/src/remnux/file-magic_V0_0_5/file-magic.py
    - mode: 755
    - watch:
      - file: remnux-scripts-file-magic-shebang
