# Source: https://github.com/chrislee35/passivedns-client
# Author: Chris Lee

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
  
# TODO - touch $HOME/.passivedns-client
