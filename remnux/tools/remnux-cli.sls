{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.3.8/remnux-cli-linux" -%}		
{%- set hash = "c54e83e6046914f56860791f3c1a81034a50afe275284e32a9ada4a85377effc" -%}		

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