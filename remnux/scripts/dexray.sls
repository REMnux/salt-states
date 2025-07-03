# Name: DeXRAY
# Website: http://www.hexacorn.com/blog/category/software-releases/dexray/
# Description: Extract and decode data from antivirus quarantine files.
# Category: Gather and Analyze Data
# Author: Hexacorn
# License: Free; copyright by Hexacorn.com: http://hexacorn.com/d/DeXRAY.pl
# Notes: dexray

include:
  - remnux.packages.perl
  - remnux.perl-packages.crypt-rc4
  - remnux.perl-packages.crypt-blowfish
  - remnux.perl-packages.archive-zip
  - remnux.perl-packages.digest-crc
  - remnux.perl-packages.ole-storagelite

remnux-scripts-dexray-source:
  file.managed:
    - name: /usr/local/bin/dexray
    - source: https://hexacorn.com/d/DeXRAY.pl
    - source_hash: sha256=6b11902badba2e0c2a811bdc9fe4e32a8654eb61fbb66f9e65c14b7d18b9e6fc
    - mode: 755
    - requires:
      - sls: remnux.packages.perl
      - sls: remnux.perl-packages.crypt-rc4
      - sls: remnux.perl-packages.crypt-blowfish
      - sls: remnux.perl-packages.archive-zip
      - sls: remnux.perl-packages.digest-crc
      - sls: remnux.perl-packages.ole-storagelite
