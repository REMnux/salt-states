# Name: pedump
# Website: https://github.com/zed-0xff/pedump
# Description: Statically analyze PE files.
# Category: Examine Static Properties: PE Files
# Author: Andrey "Zed" Zaikin
# License: MIT License: https://github.com/zed-0xff/pedump/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.ruby

pedump:
  gem.installed:
    - require:
      - pkg: ruby
