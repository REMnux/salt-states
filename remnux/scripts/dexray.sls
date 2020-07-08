# Name: DeXRAY
# Website: http://www.hexacorn.com/blog/category/software-releases/dexray/
# Description: Perl script to decrypt AV quarantined files and metadata
# Category: Artifact Extraction and Decoding: Deobfuscation
# Author: Hexacorn
# License: Copyright Hexacorn.com (http://hexacorn.com/d/DeXRAY.pl)
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
    - source_hash: sha256=91582ff3af13565be2d0efb937f1708070d58b6159cf362ea6b9a07cf448e550
    - mode: 755
    - requires:
      - sls: remnux.packages.perl
      - sls: remnux.perl-packages.crypt-rc4
      - sls: remnux.perl-packages.crypt-blowfish
      - sls: remnux.perl-packages.archive-zip
      - sls: remnux.perl-packages.digest-crc
      - sls: remnux.perl-packages.ole-storagelite

