# Name: capa
# Website: https://github.com/fireeye/capa
# Description: Detect suspicious capabilities in PE files.
# Category: Statically Analyze Code: PE Files
# Author: FireEye Inc, Willi Ballenthin: https://twitter.com/williballenthin, Moritz Raabe: https://twitter.com/m_r_tz
# License: Apache License 2.0: https://github.com/fireeye/capa/blob/master/LICENSE.txt
# Notes: 

remnux-tools-capa-source:
  file.managed:
    - name: /usr/local/src/remnux/files/capa-v7.0.1-linux.zip
    - source: https://github.com/mandiant/capa/releases/download/v7.0.1/capa-v7.0.1-linux.zip
    - source_hash: 0edbcc9d7c98f167fb3040a4158091098bba2c01455594c3cc8dc905494a7915
    - makedirs: True

remnux-tools-capa-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/capa-v7.0.1-linux
    - source: /usr/local/src/remnux/files/capa-v7.0.1-linux.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-tools-capa-source

remnux-tools-capa-binary:
  file.managed:
    - name: /usr/local/bin/capa
    - source: /usr/local/src/remnux/capa-v7.0.1-linux/capa
    - mode: 755
    - require:
      - archive: remnux-tools-capa-archive

remnux-tools-capa-cleanup1:
  file.absent:
    - name: /usr/local/share/capa-rules
    - require:
      - file: remnux-tools-capa-binary
