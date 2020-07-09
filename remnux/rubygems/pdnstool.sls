# Name: pdnstool
# Website: https://github.com/chrislee35/passivedns-client
# Description: Query passive DNS databases for DNS data.
# Category: Gather and Analyze Data
# Author: Chris Lee
# License: MIT License: https://github.com/chrislee35/passivedns-client/blob/master/LICENSE.txt
# Notes:

include:
  - remnux.packages.ruby
  - remnux.packages.ruby-dev
  - remnux.packages.build-essential
  - remnux.packages.libsqlite3-dev

passivedns-client:
  gem.installed:
    - require:
      - pkg: ruby
      - pkg: ruby-dev
      - pkg: build-essential
      - pkg: libsqlite3-dev
