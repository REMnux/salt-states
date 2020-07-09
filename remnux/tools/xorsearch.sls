# Name: XORSearch
# Website: https://blog.didierstevens.com/programs/xorsearch/
# Description: Locate and decode strings obfuscated using common techniques.
# Category: Examine Static Properties: Deobfuscation, Dynamically Reverse-Engineer Code: Shellcode
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: xorsearch

remnux-tools-xorsearch-source:
  file.managed:
    - name: /usr/local/src/remnux/files/XORSearch_V1_11_3.zip
    - source: https://github.com/DidierStevens/FalsePositives/raw/master/XORSearch_V1_11_3.zip
    - source_hash: 50d1cdf5fe93e29e1d7fcb3cf2256ceac0034cbd887e4dac1cb897e14b28bc16
    - makedirs: True

remnux-tools-xorsearch-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/XORSearch_V1_11_3
    - source: /usr/local/src/remnux/files/XORSearch_V1_11_3.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-xorsearch-source

remnux-tools-xorsearch-binary:
  file.managed:
    - name: /usr/local/bin/xorsearch
    - source: /usr/local/src/remnux/XORSearch_V1_11_3/Linux/xorsearch-x64-dynamic
    - mode: 755
    - watch:
      - archive: remnux-tools-xorsearch-archive