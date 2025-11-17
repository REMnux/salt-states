# Name: Wine
# Website: https://www.winehq.org
# Description: Run Windows applications.
# Category: Dynamically Reverse-Engineer Code: General, General Utilities
# Author: https://wiki.winehq.org/Acknowledgements
# License: GNU Lesser General Public License (LGPL) v2.1 or later: https://wiki.winehq.org/Licensing
# Notes: wine

include:
  - remnux.repos.winehq

remnux-packages-wine-i386-architecture:
  cmd.run:
    - name: dpkg --add-architecture i386 && apt-get update
    - unless: dpkg --print-foreign-architectures | grep -q i386

remnux-packages-wine-i386-deps:
  cmd.run:
    - name: apt-get install -y libc6:i386 libstdc++6:i386 libncurses5:i386 zlib1g:i386
    - unless: dpkg -l | grep -q "ii  libncurses5:i386" && dpkg -l | grep -q "ii  zlib1g:i386"
    - require:
      - cmd: remnux-packages-wine-i386-architecture

remnux-packages-wine:
  pkg.installed:
    - name: winehq-stable
    - require:
      - cmd: remnux-packages-wine-i386-deps
      - sls: remnux.repos.winehq
