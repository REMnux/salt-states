include:
  - remnux.packages.ruby

origami:
  gem.installed:
    - version: 1.2.7 # Note: need version less than 2 for ruby less than 2
    - require:
      - pkg: ruby
