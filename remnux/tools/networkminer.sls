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
    - name: /usr/local/src/remnux/files/networkminer-3.1.zip
    - source: https://download.netresec.com/networkminer/NetworkMiner_3-1.zip
    - source_hash: sha256=782e3d4d0b917a5aadf59966ab7d21ab30dbd593eff14e426f2b580a2e3f89e1
    - makedirs: True
    - replace: False
    - require:
      - sls: remnux.packages.mono-devel

remnux-networkminer-archive:
  archive.extracted:
    - name: /usr/local/
    - source: /usr/local/src/remnux/files/networkminer-3.1.zip
    - enforce_toplevel: True
    - force: true
    - watch:
      - file: remnux-networkminer-source

/usr/local/NetworkMiner_3-1/NetworkMiner.exe:
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
        - file: /usr/local/NetworkMiner_3-1/NetworkMiner.exe
    - contents:
      - '#!/bin/bash'
      - mono /usr/local/NetworkMiner_3-1/NetworkMiner.exe "$@"

remnux-networkminer-cleanup:
  file.absent:
    - names: 
      - /usr/local/NetworkMiner_2-5
      - /usr/local/NetworkMiner_2-6
      - /usr/local/NetworkMiner_2-7-1
      - /usr/local/NetworkMiner_2-7-2
      - /usr/local/NetworkMiner_2-7-3
      - /usr/local/NetworkMiner_2-8-1
      - /usr/local/NetworkMiner_2-9
      - /usr/local/NetworkMiner_3-0
    - require:
      - file: remnux-networkminer-wrapper
