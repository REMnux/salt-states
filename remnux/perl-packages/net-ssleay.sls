include:
  - remnux.packages.perl
  - remnux.packages.build-essential
  - remnux.packages.libssl-dev

remnux-perl-packages-net-ssleay-install:
  cmd.run:
    - name: cpan install Net::SSLeay
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.libssl-dev
