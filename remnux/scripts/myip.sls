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
    - source_hash: sha256=5d9a56807c596dfbb186123d175aaa753a2f3b092b34a201d42134e26edda48d
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.iproute2