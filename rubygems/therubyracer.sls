include:
  - remnux.packages.ruby

therubyracer:
  gem.installed:
    - require:
      - pkg: ruby
