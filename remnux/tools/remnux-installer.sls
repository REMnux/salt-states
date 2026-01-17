# Name: REMnux Installer
# Website: https://github.com/REMnux/distro
# Description: Install and upgrade the REMnux distro using Cast.
# Category: General Utilities
# Author: Lenny Zeltser
# License: MIT License: https://github.com/REMnux/distro/blob/master/LICENSE
# Notes: remnux

{%- set legacy_source = "https://github.com/REMnux/remnux-cli/releases/download/v" -%}
{% set legacy_hash = "c46c732f5ab8f33ce957db8b6f0827554bf100b8a26b4765410b252429a26380" %}
{% set legacy_version = "1.5.1" %}

{% set remnux_hash = "94673eb529ec6a363f332fb68c8e94bcd2ec2137746ccfce5acc45f65016f91b" %}
{% set remnux_diag_hash = "e45477b8d5f82d0c02ba9a8a2ad8f7909b7d328d2dfa02d39846fdd6c3a2dc9b" %}

include:
  - remnux.packages.cast

# Cast-based installer - primary command
remnux-tool-remnux-installer:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: https://github.com/REMnux/distro/raw/refs/heads/master/files/remnux-installer.sh
    - source_hash: sha256={{ remnux_hash }}
    - mode: 755
    - require:
      - sls: remnux.packages.cast

# Legacy Node.js installer - available as remnux-cli-legacy
remnux-tool-remnux-cli-legacy:
  file.managed:
    - name: /usr/local/bin/remnux-cli-legacy
    - source: {{ legacy_source }}{{ legacy_version }}/remnux-cli-linux
    - source_hash: sha256={{ legacy_hash }}
    - mode: 755

# Diagnostic tool
remnux-tool-remnux-diag:
  file.managed:
    - name: /usr/local/bin/remnux-diag
    - source: https://raw.githubusercontent.com/REMnux/distro/refs/heads/master/files/remnux-diag.py
    - source_hash: sha256={{ remnux_diag_hash }}
    - mode: 755
