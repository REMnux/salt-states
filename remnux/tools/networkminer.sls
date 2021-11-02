# Name: Network Miner Free Edition
# Website: https://www.netresec.com/
# Description: Examine network traffic and carve PCAP capture files.
# Category: Explore Network Interactions: Monitoring
# Author: NETRESEC AB
# License: GNU General Public License (GPL) v2: https://www.netresec.com/?page=NetworkMinerSourceCode
# Notes: networkminer

include:
  - remnux.packages.mono-devel

remnux-networkminer-source:
  file.managed:
    - name: /usr/local/src/remnux/files/networkminer-2.7.2.zip
    - source: https://www.netresec.com/?download=NetworkMiner
    - source_hash: sha256=094e14271a560a8880d3dded329c3d7cd9c84bdee527f926261c1b080a639b7f
    - makedirs: True
    - replace: False
    - require:
      - sls: remnux.packages.mono-devel

remnux-networkminer-archive:
  archive.extracted:
    - name: /usr/local/
    - source: /usr/local/src/remnux/files/networkminer-2.7.2.zip
    - enforce_toplevel: True
    - force: true
    - watch:
      - file: remnux-networkminer-source

/usr/local/NetworkMiner_2-7-2/NetworkMiner.exe:
  file.managed:
    - mode: 755
    - replace: False
    - watch:
      - archive: remnux-networkminer-archive

remnux-networkminer-wrapper:
  file.managed:
    - name: /usr/local/bin/networkminer
    - mode: 755
    - replace: True
    - watch:
        - file: /usr/local/NetworkMiner_2-7-2/NetworkMiner.exe
    - contents:
      - '#!/bin/bash'
      - mono /usr/local/NetworkMiner_2-7-2/NetworkMiner.exe "$@"

remnux-networkminer-cleanup:
  file.absent:
    - names: 
      - /usr/local/NetworkMiner_2-5
      - /usr/local/NetworkMiner_2-6
      - /usr/local/NetworkMiner_2-7-1
    - require:
      - file: remnux-networkminer-wrapper
