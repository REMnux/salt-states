# Name: GoReSym
# Website: https://github.com/mandiant/GoReSym
# Description: Extract metadata and symbols from Go binaries, including stripped ones.
# Category: Examine Static Properties: Go
# Author: Mandiant: https://github.com/mandiant
# License: MIT License: https://github.com/mandiant/GoReSym/blob/master/LICENSE
# Notes: GoReSym

remnux-tools-goresym-source:
  file.managed:
    - name: /usr/local/src/remnux/files/GoReSym-linux.zip
    - source: https://github.com/mandiant/GoReSym/releases/download/v3.1.2/GoReSym-linux.zip
    - source_hash: a5dd22d0c22dba417e13878e509875f33075062516069135f7e163601733841f
    - makedirs: True

remnux-tools-goresym-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/GoReSym-linux
    - source: /usr/local/src/remnux/files/GoReSym-linux.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-tools-goresym-source

remnux-tools-goresym-binary:
  file.managed:
    - name: /usr/local/bin/GoReSym
    - source: /usr/local/src/remnux/GoReSym-linux/GoReSym
    - mode: 755
    - require:
      - archive: remnux-tools-goresym-archive
