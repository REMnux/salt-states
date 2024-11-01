# Name: REMnux Installer
# Website: https://github.com/REMnux/remnux-cli
# Description: Install and upgrade the REMnux distro. 
# Category: General Utilities
# Author: Harbingers LLC, Erik Kristensen, revisions by Lenny Zeltser
# License: MIT License: https://github.com/REMnux/remnux-cli/blob/master/LICENSE
# Notes: remnux

{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v" -%}		
{% set hash = "5f890d09294358195afa0428246b43fb1d9eb104f079554f5b9037e400497c04" %}		
{% set version = "1.4.2" %}

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}{{ version }}/remnux-cli-linux
    - source_hash: sha256={{ hash }}
    - mode: 755
