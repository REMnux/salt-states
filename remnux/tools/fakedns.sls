# Name: fakedns.py
# Website: https://code.activestate.com/recipes/491264-mini-fake-dns-server/
# Description: Extract and decompile ActionScript from Flash (SWF) files
# Category: Network Interactions
# Author: Francisco Santos, modifications by Kevin Murray
# License: Freeware
# Notes: 

include:
  - remnux.packages.python

remnux-tools-fakedns-source:
  file.managed:
    - name: /usr/local/src/remnux/files/fakedns.py
    - source: https://github.com/REMnux/distro/raw/master/files/fakedns.py
    - source_hash: 567dc60f02e87623fa26ed4707756a1accf7b8c9c71b2661d8b7b2a8c662ce8c
    - makedirs: True
    - require:
        - sls: remnux.packages.python

remnux-tools-fakedns-binary:
  file.managed:
    - name: /usr/local/bin/fakedns
    - source: /usr/local/src/remnux/files/fakedns.py
    - mode: 755
    - watch:
        - file: remnux-tools-fakedns-source