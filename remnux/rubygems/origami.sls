# Name: Origami
# Website: https://github.com/gdelugre/origami
# Description: Parse, modify, generate PDF files.
# Category: Analyze Documents: PDF
# Author: Guillaume Delugré
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/gdelugre/origami/blob/master/COPYING.LESSER
# Notes: pdfcop, pdfdecompress, pdfdecrypt, pdfextract, etc.

include:
  - remnux.packages.ruby
  - remnux.rubygems.therubyracer

origami:
  gem.installed:
    - require:
      - pkg: ruby
      - sls: remnux.rubygems.therubyracer
