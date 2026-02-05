# Name: REMnux Installer
# Website: https://github.com/REMnux/distro/blob/master/files/remnux-installer.sh
# Description: Install and update the REMnux distro.
# Category: General Utilities
# Author: Lenny Zeltser
# License: Public Domain
# Notes: This is a wrapper around the Cast installer that the script uses behind the scenes. To run the tool on REMnux, type `remnux`

{% set remnux_hash = "e20d089faa8ce81f6998b746b4b1c5763a3909dc502997b9402b4b3121208e74" %}
{% set remnux_diag_hash = "b8f54918a28212768c2c062598ec722803a8a3e48f85c7b8db869d0774aeb63b" %}

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
