# Name: capa
# Website: https://github.com/fireeye/capa
# Description: Detect suspicious capabilites in PE files.
# Category: Statically Analyze Code: PE Files
# Author: FireEye Inc, Willi Ballenthin: https://twitter.com/williballenthin, Moritz Raabe: https://twitter.com/m_r_tz
# License: Apache License 2.0: https://github.com/fireeye/capa/blob/master/LICENSE.txt
# Notes: 

remnux-tools-capa-source:
  file.managed:
    - name: /usr/local/src/remnux/files/capa-v2.0.0-linux.zip
    - source: https://github.com/fireeye/capa/releases/download/v2.0.0/capa-v2.0.0-linux.zip
    - source_hash: 3377410ee0c01df9e96d770e23796236e26b30192ab9016a2994e65e185d9497
    - makedirs: True

remnux-tools-capa-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/capa-v2.0.0-linux
    - source: /usr/local/src/remnux/files/capa-v2.0.0-linux.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-tools-capa-source

remnux-tools-capa-binary:
  file.managed:
    - name: /usr/local/bin/capa
    - source: /usr/local/src/remnux/capa-v2.0.0-linux/capa
    - mode: 755
    - require:
      - archive: remnux-tools-capa-archive

remnux-tools-capa-cleanup1:
  file.absent:
    - name: /usr/local/share/capa-rules
    - require:
      - file: remnux-tools-capa-binary