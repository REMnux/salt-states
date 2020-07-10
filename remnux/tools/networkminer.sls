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
    - name: /usr/local/src/remnux/files/networkminer-2.5.2.zip
    - source: https://www.netresec.com/?download=NetworkMiner
    - source_hash: sha256=3f11dc812a9a3c84fafa29660e6142464582825569771e1f60bd6568e0269b23
    - makedirs: True
    - replace: False
    - require:
      - sls: remnux.packages.mono-devel

remnux-networkminer-archive:
  archive.extracted:
    - name: /usr/local/
    - source: /usr/local/src/remnux/files/networkminer-2.5.2.zip
    - enforce_toplevel: True
    - force: true
    - watch:
      - file: remnux-networkminer-source

/usr/local/NetworkMiner_2-5/NetworkMiner.exe:
  file.managed:
    - mode: 755
    - replace: False
    - watch:
      - archive: remnux-networkminer-archive

remnux-networkminer-wrapper:
  file.managed:
    - name: /usr/local/bin/networkminer
    - mode: 755
    - replace: False
    - watch:
        - file: /usr/local/NetworkMiner_2-5/NetworkMiner.exe
    - contents:
      - '#!/bin/bash'
      - mono /usr/local/NetworkMiner_2-5/NetworkMiner.exe ${*}