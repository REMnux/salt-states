{% set version = "9.20.3" -%}
{% set hash = "5490446ace6880949938dbf708f8e370cf54f89f519912d18860e794e2c76c3d" -%}

include:
  - remnux.packages.firefox

remnux-tools-cyberchef:
  archive.extracted:
    - name: /usr/local/cyberchef
    - enforce_toplevel: False
    - source: https://gchq.github.io/CyberChef/CyberChef_v{{ version }}.zip
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
        firefox /usr/local/cyberchef/CyberChef_v{{ version }}.html