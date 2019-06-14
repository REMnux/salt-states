# Author: Didier Stevens

remnux-scripts-base64dump-source:
  file.managed:
    - name: /usr/local/src/remnux/files/base64dump_V0_0_9.zip
    - source: https://didierstevens.com/files/software/base64dump_V0_0_9.zip
    - source_hash: sha256=01264F82CEFB7B1D2DF51A8DB190840FE6C368C9C3D63566CF14CE4983F73D5A
    - makedirs: True

remnux-scripts-base64dump-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/base64dump-0.0.9
    - source: /usr/local/src/remnux/files/base64dump_V0_0_9.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-base64dump-source

remnux-scripts-base64dump-binary:
  file.managed:
    - name: /usr/local/bin/base64dump.py
    - source: /usr/local/src/remnux/base64dump-0.0.9/base64dump.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-base64dump-archive
