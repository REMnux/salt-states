# Name: re-search.py
# Website: https://blog.didierstevens.com/2021/05/23/update-re-search-py-version-0-0-17/
# Description: Search the file for built-in regular expressions of common suspicious artifacts.
# Category: Examine Static Properties: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: 

include:
  - remnux.packages.python3

remnux-scripts-re-search-source:
  file.managed:
    - name: /usr/local/src/remnux/files/re-search_V0_0_17.zip
    - source: https://didierstevens.com/files/software/re-search_V0_0_17.zip
    - source_hash: sha256=0D74709B9F26FC7F6EEADAEE1BAA3AF7AADAA618F88B1C267BA5A063C8E3D997
    - makedirs: True
    - require:
      - sls: remnux.packages.python3

remnux-scripts-re-search-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/re-search_V0_0_17
    - source: /usr/local/src/remnux/files/re-search_V0_0_17.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-scripts-re-search-source

remnux-scripts-re-search-binary:
  file.managed:
    - name: /usr/local/bin/re-search.py
    - source: /usr/local/src/remnux/re-search_V0_0_17/re-search.py
    - mode: 755
    - require:
      - archive: remnux-scripts-re-search-archive

remnux-scripts-re-search-shebang:
  file.replace:
    - name: /usr/local/bin/re-search.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/env python3'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-re-search-binary

remnux-scripts-re-search-reextra:
  file.managed:
    - name: /usr/local/bin/reextra.py
    - source: /usr/local/src/remnux/re-search_V0_0_17/reextra.py
    - mode: 644
    - require:
      - archive: remnux-scripts-re-search-archive