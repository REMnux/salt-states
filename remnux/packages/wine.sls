# Name: Wine
# Website: https://www.winehq.org
# Description: Run Windows applications.
# Category: Other Tasks
# Author: https://wiki.winehq.org/Acknowledgements
# License: https://wiki.winehq.org/Licensing
# Notes: wine

include:
  - remnux.packages.i386-architecture

remnux-packages-wine:
  pkg.installed:
    - name: wine-stable  
    - require:
      - sls: remnux.packages.i386-architecture