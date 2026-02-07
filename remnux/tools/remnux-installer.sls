# Name: REMnux Installer
# Website: https://github.com/REMnux/distro/blob/master/files/remnux-installer.sh
# Description: Install and update the REMnux distro.
# Category: General Utilities
# Author: Lenny Zeltser
# License: Public Domain
# Notes: This is a wrapper around the Cast installer that the script uses behind the scenes. To run the tool on REMnux, type `remnux`

{% set remnux_hash = "15581da24c906126aba2c1e21001311d7a93d9d017c95597c662372248964661" %}
{% set remnux_diag_hash = "bc32378422a5431ee13e162e5eb642bedffdd2d47a5f19fd8d16e27cb14cab40" %}

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

# Remove legacy CLI if present on system
remnux-tool-remnux-cli-legacy-removed:
  file.absent:
    - name: /usr/local/bin/remnux-cli-legacy

# Diagnostic tool
remnux-tool-remnux-diag:
  file.managed:
    - name: /usr/local/bin/remnux-diag
    - source: https://raw.githubusercontent.com/REMnux/distro/refs/heads/master/files/remnux-diag.py
    - source_hash: sha256={{ remnux_diag_hash }}
    - mode: 755
