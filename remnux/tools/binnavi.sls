# Name: BinNavi
# Website: https://github.com/google/binnavi
# Description: IDE that allows to inspect, navigate, edit and annotate control flow graphs and call graphs of disassembled code. 
# Category: Statically Analyze Code: General
# Author: Google/Zynamics
# License: Apache License 2.0: https://github.com/google/binnavi/blob/master/LICENSE
# Notes: binnavi

include:
  - remnux.packages.default-jre
  - remnux.packages.postgresql

remnux-tools-binnavi-directory:
  file.directory:
    - name: /usr/local/binnavi/
    - user: root
    - group: root
    - mode: 755
    - makedirs: true
    - require:
      - sls: remnux.packages.postgresql

remnux-tools-binnavi-source:
  file.managed:
    - name: /usr/local/binnavi/binnavi-all.jar
    - source: https://github.com/google/binnavi/releases/download/v6.1.0/binnavi-all.jar
    - source_hash: 0a5d27548a76c5dfb396ded86c103c35070ceffec97e63c16742dac55f1e6284
    - mode: 755
    - watch:
      - file: remnux-tools-binnavi-directory
    - require:
      - file: remnux-tools-binnavi-directory

remnux-tools-binnavi-wrapper:
  file.managed:
    - name: /usr/local/bin/binnavi
    - mode: 755
    - watch:
      - file: remnux-tools-binnavi-source
    - contents:
      - '#!/bin/bash'
      - sudo systemctl start postgresql;
      - java --illegal-access=warn -jar /usr/local/binnavi/binnavi-all.jar ${*}

