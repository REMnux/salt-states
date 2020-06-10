# Name: box-js
# Website: https://github.com/CapacitorSet/box-js
# Description: nodejs tool to analyze malicious JavaScript
# Category: Examine browser malware: JavaScript
# Author: CapacitorSet
# License: https://github.com/CapacitorSet/box-js/blob/master/LICENSE
# Notes:

include:
  - remnux.packages.nodejs
  - remnux.packages.npm

box-js:
  npm.installed:
    - require:
      - sls: remnux.packages.nodejs
      - sls: remnux.packages.npm
