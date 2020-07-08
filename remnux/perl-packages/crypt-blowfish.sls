include:
  - remnux.packages.perl
  - remnux.packages.build-essential

remnux-perl-packages-crypt-blowfish-install:
  cmd.run:
    - name: cpan install Crypt::Blowfish
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.build-essential
