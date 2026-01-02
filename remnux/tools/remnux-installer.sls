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

{% set remnux_ng_hash = "bf15770f60302755459bb6d0db39f891459600e7102ccfcf0760b41af472ee67" %}
{% set remnux_diag_hash = "e45477b8d5f82d0c02ba9a8a2ad8f7909b7d328d2dfa02d39846fdd6c3a2dc9b" %}

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

remnux-tool-remnux-diag:
  file.managed:
    - name: /usr/local/bin/remnux-diag
    - source: https://raw.githubusercontent.com/REMnux/distro/refs/heads/master/files/remnux-diag.py
    - source_hash: sha256={{ remnux_diag_hash }}
    - mode: 755

