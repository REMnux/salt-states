{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.3.3/remnux-cli-linux" -%}		
{%- set hash = "8193df477c0e0f14b53d018db141b969ab48f8da550384ef6d6e51482ebdda9d" -%}		

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