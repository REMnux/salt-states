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
    - force_reinstall: true
    - require:
      - sls: remnux.packages.nodejs
      - sls: remnux.packages.curl
