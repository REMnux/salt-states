# Name: Origamindee
# Website: https://github.com/mindee/origamindee
# Description: Parse, modify, generate PDF files.
# Category: Analyze Documents: PDF
# Author: Guillaume Delugre (original), Mindee (fork maintainer)
# License: GNU Lesser General Public License (LGPL) v3
# Notes: pdfcop, pdfdecompress, pdfdecrypt, pdfextract, etc.

include:
  - remnux.packages.ruby

origamindee:
  gem.installed:
    - require:
      - pkg: ruby
