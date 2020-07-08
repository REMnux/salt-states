include:
  - remnux.packages.perl
  - remnux.packages.build-essential

remnux-perl-packages-ole-storagelite-install:
  cmd.run:
    - name: cpan install OLE::Storage_Lite
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: remnux.packages.perl
      - sls: remnux.packages.build-essential
