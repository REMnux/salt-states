# Source: https://github.com/gdelugre/origami
# Author: Guillaume Delugré

include:
  - remnux.packages.ruby
  - remnux.rubygems.therubyracer

origami:
  gem.installed:
    - require:
      - pkg: ruby
      - sls: remnux.rubygems.therubyracer
