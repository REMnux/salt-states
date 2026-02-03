# Name: cfr
# Website: https://www.benf.org/other/cfr/
# Description: Java decompiler.
# Category: Statically Analyze Code: Java
# Author: Lee Benfield
# License: MIT License: https://github.com/leibnitz27/cfr/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.default-jre

remnux-tools-cfr-directory:
  file.directory:
    - name: /usr/local/cfr/
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

remnux-tools-cfr-source:
  file.managed:
    - name: /usr/local/cfr/cfr-0.152.jar
    - source: https://github.com/leibnitz27/cfr/releases/download/0.152/cfr-0.152.jar
    - source_hash: f686e8f3ded377d7bc87d216a90e9e9512df4156e75b06c655a16648ae8765b2
    - mode: 755
    - watch:
      - file: remnux-tools-cfr-directory
    - require:
      - file: remnux-tools-cfr-directory

remnux-tools-cfr-wrapper:
  file.managed:
    - name: /usr/local/bin/cfr
    - mode: 755
    - watch:
      - file: remnux-tools-cfr-source
    - contents:
      - '#!/bin/bash'
      - java -jar /usr/local/cfr/cfr-0.152.jar ${*}

