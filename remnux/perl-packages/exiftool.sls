# Name: ExifTool
# Website: https://exiftool.org/
# Description: Tool to read from, write to, and edit EXIF metadata of various file types
# Category: Examine Static Properties
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Notes: 

include:
  - remnux.packages.perl
  - remnux.packages.build-essential

remnux-perl-packages-exiftool:
  cmd.run:
    - name: cpan install Image::ExifTool
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.build-essential
