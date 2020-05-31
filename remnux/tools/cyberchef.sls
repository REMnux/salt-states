# Name: CyberChef
# Website: https://github.com/gchq/CyberChef/
# Description: Decode and otherwise analyze data
# Category: 
# Author: GCHQ
# License: https://github.com/gchq/CyberChef/blob/master/LICENSE
# Notes: cyberchef

{% set version = "9.20.3" -%}
{% set hash = "033c0a44e0b80b6ac58bb5c00073eaccc0ae3e56853b91095930f48eeebcdaef" -%}

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
        #!/bin/bash
        firefox /usr/local/cyberchef/CyberChef_v{{ version }}.html &
