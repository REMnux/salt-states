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
    - source_hash: 474b4e296be86c245fec8e28e435398c5d6ada736de1552ff21950419ccb282b
    - mode: 755

