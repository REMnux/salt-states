# Name: extract_swf
# Website: https://github.com/digitalsleuth/extract_swf
# Description: Extract potential SWF files from Flash Projector binaries.
# Category: Statically Analyze Code: Flash
# Author: Nathan Ostgard, Updated for Python 3 by Corey Forman
# License: Free, unknown license
# Notes: 

remnux-scripts-extract_swf-source:
  file.managed:
    - name: /usr/local/bin/extract_swf.py
    - source: https://raw.githubusercontent.com/digitalsleuth/extract_swf/master/extract_swf.py
    - source_hash: 665358926164eb2eccfa246ec4ea0b6b59409d90f0086f7e12559586d2195ac9
    - mode: 755

