include:
  - remnux.packages.perl
  - remnux.packages.build-essential

remnux-perl-packages-digest-crc-install:
  cmd.run:
    - name: cpan install Digest::CRC
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.build-essential
