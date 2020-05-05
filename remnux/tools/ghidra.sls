# Name: Ghidra
# Website: https://ghidra-sre.org
# Description: Software reverse engineering tool suite
# Category: Static Analysis
# Author: National Security Agency
# License: https://github.com/NationalSecurityAgency/ghidra/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.openjdk-11-jdk

remnux-tools-ghidra-source:
  file.managed:
    - name: /usr/local/src/remnux/files/ghidra_9.1.2_PUBLIC_20200212.zip
    - source: https://ghidra-sre.org/ghidra_9.1.2_PUBLIC_20200212.zip
    - source_hash: sha256=ebe3fa4e1afd7d97650990b27777bb78bd0427e8e70c1d0ee042aeb52decac61
    - makedirs: true

remnux-tools-ghidra-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/
    - source: /usr/local/src/remnux/files/ghidra_9.1.2_PUBLIC_20200212.zip
    - enforce_toplevel: false
    - watch:
      - file: remnux-tools-ghidra-source

/usr/local/bin/ghidra:
  file.symlink:
    - target: /usr/local/src/remnux/ghidra_9.1.2_PUBLIC/ghidraRun
    - watch:
      - archive: remnux-tools-ghidra-archive
