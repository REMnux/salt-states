{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.3.9/remnux-cli-linux" -%}		
{%- set hash = "88cd35b7807fc66ee8b51ee08d0d2518b2329c471b034ee3201e004c655be8d6" -%}		

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