# Name: ExifTool
# Website: https://exiftool.org/
# Description: Tool to read from, write to, and edit EXIF metadata of various file types
# Category: Examine Static Properties: General
# Author: Phil Harvey
# License: "This is free software; you can redistribute it and/or modify it under the same terms as Perl itself": https://exiftool.org/#license
# Notes: exiftool

{% set version = "13.33" %}

include:
  - remnux.packages.perl
  - remnux.packages.build-essential

remnux-perl-packages-exiftool-download:
  file.managed:
    - name: /usr/local/src/remnux/files/Image-ExifTool-{{ version }}.tar.gz
    - source: https://exiftool.org/Image-ExifTool-{{ version }}.tar.gz
    - skip_verify: True
    - makedirs: True

remnux-perl-packages-exiftool-extract:
  archive.extracted:
    - name: /usr/local/src/remnux/exiftool
    - source: /usr/local/src/remnux/files/Image-ExifTool-{{ version }}.tar.gz
    - enforce_toplevel: False
    - force: True
    - require:
      - file: remnux-perl-packages-exiftool-download

remnux-perl-packages-exiftool-build:
  cmd.run:
    - name: perl Makefile.PL
    - cwd: /usr/local/src/remnux/exiftool/Image-ExifTool-{{ version }}
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.build-essential

remnux-perl-packages-exiftool-install:
  cmd.run:
    - name: make install
    - cwd: /usr/local/src/remnux/exiftool/Image-ExifTool-{{ version }}
    - require:
      - cmd: remnux-perl-packages-exiftool-build

remnux-perl-packages-remove-exiftool-directory:
  file.absent:
    - name: /usr/local/src/remnux/exiftool
    - require:
      - cmd: remnux-perl-packages-exiftool-install

remnux-perl-packages-remove-exiftool-archive:
  file.absent:
    - name: /usr/local/src/remnux/files/Image-ExifTool-{{ version }}.tar.gz
    - require:
      - cmd: remnux-perl-packages-exiftool-install
