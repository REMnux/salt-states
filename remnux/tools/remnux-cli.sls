{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.3.2/remnux-cli-linux" -%}		
{%- set hash = "e335872b1026136102b6ca5d8b4fbf2f20cadd1ea5117955381c1520fd0843de" -%}		

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