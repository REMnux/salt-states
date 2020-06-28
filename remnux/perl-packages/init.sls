include:
  - remnux.perl-packages.exiftool

remnux-perl-packages:
  test.nop:
    - require:
      - sls: remnux.perl-packages.exiftool
