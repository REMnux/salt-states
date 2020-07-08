include:
  - remnux.packages.perl
  - remnux.packages.build-essential

remnux-perl-packages-archive-zip-install:
  cmd.run:
    - name: cpan install Archive::Zip
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.build-essential
