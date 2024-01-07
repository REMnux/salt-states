# Name: capa
# Website: https://github.com/fireeye/capa
# Description: Detect suspicious capabilities in PE files.
# Category: Statically Analyze Code: PE Files
# Author: FireEye Inc, Willi Ballenthin: https://twitter.com/williballenthin, Moritz Raabe: https://twitter.com/m_r_tz
# License: Apache License 2.0: https://github.com/fireeye/capa/blob/master/LICENSE.txt
# Notes: 

remnux-tools-capa-source:
  file.managed:
    - name: /usr/local/src/remnux/files/capa-v3.2.0-linux.zip
    - source: https://github.com/mandiant/capa/releases/download/v3.2.0/capa-v3.2.0-linux.zip
    - source_hash: 8d180d0abd75033bdce1071747a54bb6d16f558e15e0d39d443e421c81163e9f
    - makedirs: True

remnux-tools-capa-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/capa-v3.2.0-linux
    - source: /usr/local/src/remnux/files/capa-v3.2.0-linux.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-tools-capa-source

remnux-tools-capa-binary:
  file.managed:
    - name: /usr/local/bin/capa
    - source: /usr/local/src/remnux/capa-v3.2.0-linux/capa
    - mode: 755
    - require:
      - archive: remnux-tools-capa-archive

remnux-tools-capa-cleanup1:
  file.absent:
    - name: /usr/local/share/capa-rules
    - require:
      - file: remnux-tools-capa-binary
