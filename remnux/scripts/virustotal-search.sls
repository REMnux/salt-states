# Name: virustotal-search
# Website: https://blog.didierstevens.com/programs/virustotal-tools/
# Description: Search VirusTotal for file hashes.
# Category: Gather and Analyze Data
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: virustotal-search.py

remnux-scripts-virustotal-search-source:
  file.managed:
    - name: /usr/local/src/remnux/files/virustotal-search_V0_1_5.zip
    - source: https://didierstevens.com/files/software/virustotal-search_V0_1_5.zip
    - source_hash: sha256=4F614C9D01C694AEAA16F7D5E4DBFBCF37E8E8D01D382C1137F401612D02E110
    - makedirs: True

remnux-scripts-virustotal-search-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/virustotal-search_V0_1_5
    - source: /usr/local/src/remnux/files/virustotal-search_V0_1_5.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-virustotal-search-source

remnux-scripts-virustotal-search-binary:
  file.managed:
    - name: /usr/local/bin/virustotal-search.py
    - source: /usr/local/src/remnux/virustotal-search_V0_1_5/virustotal-search.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-virustotal-search-archive
