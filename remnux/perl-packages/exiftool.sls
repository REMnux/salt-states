# Name: ExifTool
# Website: https://exiftool.org/
# Description: Tool to read from, write to, and edit EXIF metadata of various file types
# Category: Examine Static Properties: General
# Author: Phil Harvey
# License: "This is free software; you can redistribute it and/or modify it under the same terms as Perl itself": https://exiftool.org/#license
# Notes: exiftool

include:
  - remnux.packages.perl
  - remnux.packages.build-essential
  - remnux.packages.liblzma-dev
  - remnux.packages.libssl-dev
  - remnux.packages.zlib1g-dev
  - remnux.packages.unzip
  - remnux.perl-packages.net-ssleay

remnux-perl-packages-exiftool:
  cmd.run:
    - name: cpan install Image::ExifTool
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.liblzma-dev
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.zlib1g-dev
      - sls: remnux.packages.unzip
      - sls: remnux.perl-packages.net-ssleay
