{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.2.6/remnux-cli-linux" -%}		
{%- set hash = "79796900999447d4ba3e256304b60a6c53ba4f1b26d6cb3b1c4231eb947eda8a" -%}		

# Name: REMnux Installer
# Website: https://github.com/REMnux/remnux-cli
# Description: Install and upgrade the REMnux distro. 
# Category: General Utilities
# Author: Harbingers LLC, Erik Kristensen, revisions by Lenny Zeltser
# License: MIT License: https://github.com/REMnux/remnux-cli/blob/master/LICENSE
# Notes: remnux

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755