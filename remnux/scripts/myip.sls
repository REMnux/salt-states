# Name: myip
# Website: https://github.com/REMnux/distro/blob/master/files/myip
# Description: Determine the IP address of the default network interface.
# Category: General Utilities
# Author: Lenny Zeltser, with input from the community
# License: Public Domain
# Notes: 

include:
  - remnux.packages.iproute2

remnux-scripts-myip-source:
  file.managed:
    - name: /usr/local/bin/myip
    - source: https://github.com/REMnux/distro/raw/master/files/myip
    - source_hash: sha256=9ccaeca2078ff9959c6a6f040998557cecd718d6f0f311312c2f437684b6c3de
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.iproute2
