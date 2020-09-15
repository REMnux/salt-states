{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.3.1/remnux-cli-linux" -%}		
{%- set hash = "36fc8d632541ee8771b33ffc4fe4732534927a5aa0cc7e3b7c2570e0cc85a388" -%}		

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