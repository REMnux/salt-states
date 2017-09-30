remnux-scripts-flare-floss-source:
  file.managed:
    - name: /usr/local/src/remnux/files/floss-1.5.0-GNU.Linux.zip
    - source: https://github.com/fireeye/flare-floss/releases/download/v1.5.0/floss-1.5.0-GNU.Linux.zip
    - source_hash: 69a30245a0180930fa61713facf5022072a82e178c86ed3e63d4e5d0142ba576
    - makedirs: True

remnux-scripts-flare-floss-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/floss-1.5.0
    - source: /usr/local/src/remnux/files/floss-1.5.0-GNU.Linux.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-flare-floss-source

remnux-scripts-flare-floss-binary:
  file.managed:
    - name: /usr/local/bin/floss
    - source: /usr/local/src/remnux/floss-1.5.0/floss
    - mode: 755
    - watch:
      - archive: remnux-scripts-flare-floss-archive
