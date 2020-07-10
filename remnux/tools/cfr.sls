# Name: cfr
# Website: https://www.benf.org/other/cfr/
# Description: Java decompiler
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
    - name: /usr/local/cfr/cfr-0.149.jar
    - source: https://github.com/leibnitz27/cfr/releases/download/0.149/cfr-0.149.jar
    - source_hash: db683b5b3bc2c20fd2fabcc9d749d5b8bcbba736f334e5ac2092173242967aca
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
      - java -jar /usr/local/cfr/cfr-0.149.jar ${*}

