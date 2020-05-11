# Name: java_idx_parser
# Website: https://github.com/digitalsleuth/Java_IDX_Parser
# Description: Python 3 script to analyze Java IDX files
# Category: Examine browser malware: Java
# Author: Brian Baskin (updated for Python 3 by Corey Forman)
# License: https://github.com/digitalsleuth/Java_IDX_Parser/blob/master/LICENSE
# Notes: idx_parser.py

remnux-scripts-java_idx_parser-source:
  file.managed:
    - name: /usr/local/bin/idx_parser.py
    - source: https://raw.githubusercontent.com/digitalsleuth/Java_IDX_Parser/master/idx_parser.py
    - source_hash: 995706f211b109798511cf46b4ccd21c30430220270e8ee616f9de0a769ab02b
    - mode: 755
