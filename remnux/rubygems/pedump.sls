# Source: https://github.com/zed-0xff/pedump
# Author: Andrey "Zed" Zaikin

include:
  - remnux.packages.ruby

pedump:
  gem.installed:
    - require:
      - pkg: ruby
