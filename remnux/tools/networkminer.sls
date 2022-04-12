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
    - name: /usr/local/src/remnux/files/networkminer-2.7.3.zip
    - source: https://www.netresec.com/?download=NetworkMiner
    - source_hash: sha256=cf477b651c3bcc70d6f5d50f9bdcb6d8cf2dd85b7018109ff474b9df3c7a0f7e
    - makedirs: True
    - replace: False
    - require:
      - sls: remnux.packages.mono-devel

remnux-networkminer-archive:
  archive.extracted:
    - name: /usr/local/
    - source: /usr/local/src/remnux/files/networkminer-2.7.3.zip
    - enforce_toplevel: True
    - force: true
    - watch:
      - file: remnux-networkminer-source

/usr/local/NetworkMiner_2-7-3/NetworkMiner.exe:
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
        - file: /usr/local/NetworkMiner_2-7-3/NetworkMiner.exe
    - contents:
      - '#!/bin/bash'
      - mono /usr/local/NetworkMiner_2-7-3/NetworkMiner.exe "$@"

remnux-networkminer-cleanup:
  file.absent:
    - names: 
      - /usr/local/NetworkMiner_2-5
      - /usr/local/NetworkMiner_2-6
      - /usr/local/NetworkMiner_2-7-1
      - /usr/local/NetworkMiner_2-7-2
    - require:
      - file: remnux-networkminer-wrapper
