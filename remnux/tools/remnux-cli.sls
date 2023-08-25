{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.3.7/remnux-cli-linux" -%}		
{%- set hash = "b80a40ca56b68a404cae8d08333fded1aff1ec7d7a126b9fd6bad219556a417f" -%}		

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