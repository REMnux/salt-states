# Name: Density Scout
# Website: http://www.cert.at/downloads/software/densityscout_en.html
# Description: Calculate density (like entropy) of files in the specified location, useful for finding packed programs
# Category: Statically examine PE files: Unpacking
# Author: Christian Wojner
# License: https://en.wikipedia.org/wiki/ISC_license
# Notes: densityscout

remnux-tools-densityscout-source:
  file.managed:
    - name: /usr/local/src/remnux/files/densityscout_build_45_linux.zip
    - source: https://www.cert.at/media/files/downloads/software/densityscout/files/densityscout_build_45_linux.zip
    - source_hash: 7d49813d407df06529e4b0138d4c0eec725c73bf9e93c0444639c6d409890f2c
    - makedirs: True

remnux-tools-densityscout-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/densityscout_build_45_linux
    - source: /usr/local/src/remnux/files/densityscout_build_45_linux.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-densityscout-source

remnux-tools-densityscout-binary:
  file.managed:
    - name: /usr/local/bin/densityscout
    - source: /usr/local/src/remnux/densityscout_build_45_linux/lin64/densityscout
    - mode: 755
    - watch:
      - archive: remnux-tools-densityscout-archive