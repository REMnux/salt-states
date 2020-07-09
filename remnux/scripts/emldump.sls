# Name: emldump
# Website: https://blog.didierstevens.com/2017/07/21/update-emldump-py-version-0-0-10/
# Description: Parse and analyze EML files
# Category: Analyze Documents: Email Messages
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Free, unknown license
# Notes: 

include:
  - remnux.python-packages.yara-python

remnux-scripts-emldump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/emldump_V0_0_10.zip
    - source: https://didierstevens.com/files/software/emldump_V0_0_10.zip
    - source_hash: sha256=c5877e252ddb61b40bffcc5403db500e672dacfe96faa7d1e0668246c5202de5
    - makedirs: True

remnux-scripts-emldump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/emldump-0.0.10
    - source: /usr/local/src/remnux/files/emldump_V0_0_10.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-emldump-source

remnux-scripts-emldump-binary:
  file.managed:
    - name: /usr/local/bin/emldump.py
    - source: /usr/local/src/remnux/emldump-0.0.10/emldump.py
    - mode: 755
    - require:
      - sls: remnux.python-packages.yara-python
    - watch:
      - archive: remnux-scripts-emldump-archive
