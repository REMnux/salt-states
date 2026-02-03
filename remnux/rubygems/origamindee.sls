# Name: Origamindee
# Website: https://github.com/mindee/origamindee
# Description: Parse, modify, generate PDF files.
# Category: Analyze Documents: PDF
# Author: Guillaume Delugre (original), Mindee (fork maintainer)
# License: GNU Lesser General Public License (LGPL) v3
# Notes: pdfcop, pdfdecompress, pdfdecrypt, pdfextract, etc.

include:
  - remnux.packages.ruby

# Remove deprecated gems that conflict with origamindee
remnux-rubygems-origami-removed:
  gem.removed:
    - name: origami
    - require:
      - pkg: ruby

remnux-rubygems-therubyracer-removed:
  gem.removed:
    - name: therubyracer
    - require:
      - pkg: ruby

origamindee:
  gem.installed:
    - require:
      - pkg: ruby
      - gem: remnux-rubygems-origami-removed
