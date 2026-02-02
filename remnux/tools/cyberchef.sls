# Name: CyberChef
# Website: https://github.com/gchq/CyberChef/
# Description: Decode and otherwise analyze data using this browser app.
# Category: Examine Static Properties: Deobfuscation
# Author: GCHQ
# License: Apache License 2.0: https://github.com/gchq/CyberChef/blob/master/LICENSE
# Notes: cyberchef

{% set version = "10.20.0" -%}
{% set hash = "3030457c151fb4a0c3c3330ef40166b0e92eeb78931cf2a622e096f77c1a704b" -%}

include:
  - remnux.packages.firefox

remnux-tools-cyberchef:
  archive.extracted:
    - name: /usr/local/cyberchef
    - enforce_toplevel: False
    - source: https://github.com/gchq/CyberChef/releases/download/v{{ version}}/CyberChef_v{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - overwrite: True
    - require:
      - sls: remnux.packages.firefox

remnux-tools-cyberchef-wrapper:
  file.managed:
    - name: /usr/local/bin/cyberchef
    - mode: 755
    - watch:
      - archive: remnux-tools-cyberchef
    - contents:
      - '#!/bin/bash'
      - firefox /usr/local/cyberchef/CyberChef_v{{ version }}.html &
