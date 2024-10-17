include:
  - remnux.perl-packages.exiftool
  - remnux.perl-packages.archive-zip
  - remnux.perl-packages.crypt-rc4
  - remnux.perl-packages.crypt-blowfish
  - remnux.perl-packages.digest-crc
  - remnux.perl-packages.ole-storagelite

remnux-perl-packages:
  test.nop:
    - require:
      - sls: remnux.perl-packages.exiftool
      - sls: remnux.perl-packages.archive-zip
      - sls: remnux.perl-packages.crypt-rc4
      - sls: remnux.perl-packages.crypt-blowfish
      - sls: remnux.perl-packages.digest-crc
      - sls: remnux.perl-packages.ole-storagelite
