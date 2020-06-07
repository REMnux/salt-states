# Name: Origami
# Website: https://github.com/gdelugre/origami
# Description: Ruby library to parse, modify, and generate PDF documents
# Category: Examine document files: PDF
# Author: Guillaume Delugré
# License: https://github.com/gdelugre/origami/blob/master/COPYING.LESSER
# Notes: 

include:
  - remnux.packages.ruby
  - remnux.rubygems.therubyracer

origami:
  gem.installed:
    - require:
      - pkg: ruby
      - sls: remnux.rubygems.therubyracer
