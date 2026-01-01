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

{% set remnux_ng_hash = "53810731a2605a44120553a1057703812f2f9f207d5aa0d4c7f6f116767779c2" %}

include:
  - remnux.packages.cast

remnux-tool-remnux-installer:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}{{ version }}/remnux-cli-linux
    - source_hash: sha256={{ hash }}
    - mode: 755

remnux-tool-remnux-ng-installer:
  file.managed:
    - name: /usr/local/bin/remnux-ng
    - source: https://github.com/REMnux/distro/raw/refs/heads/master/files/remnux-installer.sh
    - source_hash: sha256={{ remnux_ng_hash }}
    - mode: 755
    - require:
      - sls: remnux.packages.cast

