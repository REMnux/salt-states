{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.3.4/remnux-cli-linux" -%}		
{%- set hash = "23c7f4eefa7599ea2c4156f083906ea5fd99df18f306e4bb43eec0430073985a" -%}		

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