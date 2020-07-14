# Name: box-js
# Website: https://github.com/CapacitorSet/box-js
# Description: Analyze suspicious JavaScript scripts.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: CapacitorSet
# License: MIT License: https://github.com/CapacitorSet/box-js/blob/master/LICENSE
# Notes: box-js, box-export

include:
  - remnux.packages.nodejs
  - remnux.packages.curl

box-js:
  npm.installed:
    - require:
      - sls: remnux.packages.nodejs
      - sls: remnux.packages.curl

remnux-node-packages-box-export-shebang:
  file.replace:
    - name: /usr/bin/box-export
    - pattern: '#!/usr/bin/env node'
    - repl: '#!/usr/bin/env node'
    - prepend_if_not_found: True
    - count: 1
    - require:
      - npm: box-js

remnux-node-packages-box-export-version:
  file.replace:
    - name: /usr/bin/box-export
    - pattern: ./package.json
    - repl: ../../package.json
    - count: 1
    - require:
      - npm: box-js
    - watch:
      - file: remnux-node-packages-box-export-shebang

remnux-node-packages-box-export-license:
  file.replace:
    - name: /usr/bin/box-export
    - pattern: /LICENSE
    - repl: /../../LICENSE
    - count: 1
    - require:
      - npm: box-js
    - watch:
      - file: remnux-node-packages-box-export-version
