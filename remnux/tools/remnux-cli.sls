# Name: REMnux Installer
# Website: https://github.com/REMnux/remnux-cli
# Description: Install and upgrade the REMnux distro.
# Category: General Utilities
# Author: Harbingers LLC, Erik Kristensen, revisions by Lenny Zeltser
# License: MIT License: https://github.com/REMnux/remnux-cli/blob/master/LICENSE
# Notes: remnux

{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v" -%}		
{% set hash = "c46c732f5ab8f33ce957db8b6f0827554bf100b8a26b4765410b252429a26380" %}		
{% set version = "1.5.1" %}

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}{{ version }}/remnux-cli-linux
    - source_hash: sha256={{ hash }}
    - mode: 755
