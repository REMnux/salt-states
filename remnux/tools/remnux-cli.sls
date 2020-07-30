{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.2.7/remnux-cli-linux" -%}		
{%- set hash = "dfd4aa8e4c618e468df06ea8bca1e14e3329723e447073b3357e6eb365d7f3e8" -%}		

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