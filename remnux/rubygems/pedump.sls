# Name: pedump
# Website: https://github.com/zed-0xff/pedump
# Description: Statically analyze PE files.
# Category: Static Analysis
# Author: Andrey "Zed" Zaikin
# License: https://github.com/zed-0xff/pedump/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.ruby

pedump:
  gem.installed:
    - require:
      - pkg: ruby
