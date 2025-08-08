# Name: ExifTool
# Website: https://exiftool.org/
# Description: Tool to read from, write to, and edit EXIF metadata of various file types
# Category: Examine Static Properties: General
# Author: Phil Harvey
# License: "This is free software; you can redistribute it and/or modify it under the same terms as Perl itself": https://exiftool.org/#license
# Notes: exiftool

{% set version_query = salt['http.query']('https://exiftool.org/ver.txt', backend='requests', verify_ssl=True) %}
{% set version = version_query.get('body').strip() %}
{% set hash_query = salt['http.query']('https://exiftool.org/checksums.txt', backend='requests', verify_ssl=True) %}
{% set hash_content = hash_query.get('body').splitlines() %}
{% set ns = namespace(hash='') %}
{% for line in hash_content %}
{% if 'SHA2-256(Image-ExifTool-' ~ version ~ '.tar.gz)' in line %}
{% set ns.hash = line.split()[-1].strip() %}
{% endif %}
{% endfor %}

include:
  - remnux.packages.perl
  - remnux.packages.build-essential

remnux-perl-packages-exiftool-download:
  file.managed:
    - name: /usr/local/src/remnux/files/Image-ExifTool-{{ version }}.tar.gz
    - source: https://exiftool.org/Image-ExifTool-{{ version }}.tar.gz
    - source_hash: sha256={{ ns.hash }}
    - makedirs: True

remnux-perl-packages-exiftool-extract:
  archive.extracted:
    - name: /usr/local/src/remnux/exiftool
    - source: /usr/local/src/remnux/files/Image-ExifTool-{{ version }}.tar.gz
    - source_hash: sha256={{ ns.hash }}
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
