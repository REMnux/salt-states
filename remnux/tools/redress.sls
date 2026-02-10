# Name: Redress
# Website: https://github.com/goretk/redress
# Description: Analyze stripped Go binaries to recover symbols, types, source structure, and integrate with Radare2.
# Category: Examine Static Properties: Go
# Author: Joakim Kennedy: https://github.com/goretk
# License: GNU Affero General Public License v3.0: https://github.com/goretk/redress/blob/develop/LICENSE
# Notes: redress

include:
  - remnux.packages.radare2

remnux-tools-redress-source:
  file.managed:
    - name: /usr/local/src/remnux/files/redress-linux-amd64.tar.gz
    - source: https://github.com/goretk/redress/releases/download/v1.2.54/redress-v1.2.54-linux-amd64.tar.gz
    - source_hash: 276b4c4f303ce197c80c4a485523c72219651292c8a3cb8b6b2fd20488106491
    - makedirs: True
    - require:
      - sls: remnux.packages.radare2

remnux-tools-redress-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/redress-linux
    - source: /usr/local/src/remnux/files/redress-linux-amd64.tar.gz
    - enforce_toplevel: False
    - options: --strip-components=1
    - require:
      - file: remnux-tools-redress-source

remnux-tools-redress-binary:
  file.managed:
    - name: /usr/local/bin/redress
    - source: /usr/local/src/remnux/redress-linux/redress
    - mode: 755
    - require:
      - archive: remnux-tools-redress-archive
