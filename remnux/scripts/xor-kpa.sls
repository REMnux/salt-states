# Name: xor-kpa.py
# Website: https://blog.didierstevens.com/2017/06/06/update-xor-kpa-py-version-0-0-5/
# Description: Implement a XOR known plaintext attack.
# Category: Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: 

remnux-scripts-xor-kpa-source:
  file.managed:
    - name: /usr/local/src/remnux/files/xor-kpa_V0_0_5.zip
    - source: https://didierstevens.com/files/software/xor-kpa_V0_0_5.zip
    - source_hash: 7517DD44AFBFA11122FD940D76878482F50B7A2A2BCD1D7A2AF030F6CAC4F4E3
    - makedirs: True

remnux-scripts-xor-kpa-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/xor-kpa_V0_0_5
    - source: /usr/local/src/remnux/files/xor-kpa_V0_0_5.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-xor-kpa-source

remnux-scripts-xor-kpa-binary:
  file.managed:
    - name: /usr/local/bin/xor-kpa.py
    - source: /usr/local/src/remnux/xor-kpa_V0_0_5/xor-kpa.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-xor-kpa-archive
