# Name: Network Miner Free Edition
# Website: https://www.netresec.com/?download=NetworkMiner
# Description: Network Forensic Analysis Tool, packet sniffer
# Category: Examine browser malware: Websites
# Author: NETRESEC AB
# License: https://www.netresec.com/?page=NetworkMinerSourceCode
# Notes: 

remnux-wget-networkminer:
 cmd.run:
    - name: wget https://www.netresec.com/?download=NetworkMiner -O /tmp/nm.zip
  
remnux-networkminer-unzip:
  archive.extracted:
    - source: /tmp/nm.zip
    - name: /opt/

remnux-networkminer-del:
  file.absent:
    - name: /tmp/nm.zip

remnux-networkminer-dirs:
  file.directory:
    - mode: 777
    - names:
      - /opt/NetworkMiner_2-5/AssembledFiles:
        - source: /opt/NetworkMiner_2-5/AssembledFiles
      - /opt/NetworkMiner_2-5/Captures:
        - source: /opt/NetworkMiner_2-5/Captures
    - recurse:
      - mode

/opt/NetworkMiner_2-5/NetworkMiner.exe:
  file.managed:
    - mode: 755
