# Source: https://github.com/cowboyd/therubyracer
# Author: Charles Lowell

include:
  - remnux.packages.ruby
  - remnux.packages.ruby-dev
  - remnux.packages.build-essential

therubyracer:
  gem.installed:
    - require:
      - pkg: ruby
      - pkg: ruby-dev
      - pkg: build-essential
