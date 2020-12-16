# Name: msg-extractor
# Website: https://github.com/TeamMsgExtractor/msg-extractor
# Description: Extract emails and attachments from MSG files.
# Category: Analyze Documents: Email messages
# Author: https://github.com/TeamMsgExtractor/msg-extractor#credits
# License: GNU General Public LIcense v3.0: https://github.com/TeamMsgExtractor/msg-extractor/blob/master/LICENSE.txt
# Notes: extract_msg

include:
  - remnux.packages.python3-pip
  - remnux.packages.git
  - remnux.packages.tzdata

remnux-python3-packages-extract-msg:
  pip.installed:
    - name: git+https://github.com/TeamMsgExtractor/msg-extractor
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git
      - sls: remnux.packages.tzdata
