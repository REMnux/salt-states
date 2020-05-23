# Name: pdnstool
# Website: https://github.com/chrislee35/passivedns-client
# Description: Rubygem tool for passive DNS mapping
# Category: Examine browser malware: Websites
# Author: Chris Lee
# License: https://github.com/chrislee35/passivedns-client/blob/master/LICENSE.txt
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
