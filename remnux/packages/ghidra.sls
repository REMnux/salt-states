# Name: Ghidra
# Website: https://ghidra-sre.org
# Description: Software reverse engineering tool suite
# Category: Statically Analyze Code: General
# Author: National Security Agency
# License: Apache License 2.0: https://github.com/NationalSecurityAgency/ghidra/blob/master/LICENSE
# Notes: Close CodeBrowser before exiting Ghidra to prevent Ghidra from freezing when you reopen the tool (it's a Ghidra bug).

include:
  - remnux.repos.remnux

remnux-packages-ghidra:
  pkg.installed:
    - name: ghidra
    - version: latest
    - upgrade: True
    - pkgrepo: remnux

remnux-packages-ghidra-cleanup1:
  file.absent:
    - name: /usr/local/src/remnux/files/ghidra_9.1.2_PUBLIC_20200212.zip
    - require:
      - pkg: remnux-packages-ghidra

remnux-packages-ghidra-cleanup2:
  file.absent:
    - name: /usr/local/src/remnux/files/ghidra_9.2_PUBLIC_20201113.zip
    - require:
      - pkg: remnux-packages-ghidra

remnux-packages-ghidra-cleanup3:
  file.absent:
    - name: /usr/local/bin/ghidra
    - require:
      - pkg: remnux-packages-ghidra

remnux-packages-ghidra-cleanup4:
  file.absent:
    - name: /usr/local/ghidra_9.1.2_PUBLIC
    - require:
      - pkg: remnux-packages-ghidra

remnux-packages-ghidra-cleanup5:
  file.absent:
    - name: /usr/local/ghidra_9.2_PUBLIC
    - require:
      - pkg: remnux-packages-ghidra