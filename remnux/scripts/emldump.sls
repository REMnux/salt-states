# Author: Didier Stevens

remnux-scripts-emldump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/emldump_V0_0_10.zip
    - source: http://didierstevens.com/files/software/emldump_V0_0_10.zip
    - source_hash: sha256=c5877e252ddb61b40bffcc5403db500e672dacfe96faa7d1e0668246c5202de5
    - makedirs: True

remnux-scripts-emldump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/emldump-0.0.10
    - source: /usr/local/src/remnux/files/emldump_V0_0_10.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-emldump-source

remnux-scripts-empdump-binary:
  file.managed:
    - name: /usr/local/bin/emldump.py
    - source: /usr/local/src/remnux/emldump-0.0.10/emldump.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-emldump-archive
