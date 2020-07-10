# Name: accept-all-ips
# Website: https://github.com/REMnux/distro/blob/master/files/strdeob.pl
# Description: Accept connections to all IPv4 and IPv6 addresses and redirect it to the corresponding local port.
# Category: Explore Network Interactions: Services
# Author: Lenny Zeltser, with input from the community
# License: GNU General Public License (GPL) v3+
# Notes: 

include:
  - remnux.scripts.myip

remnux-scripts-accept-all-ips-source:
  file.managed:
    - name: /usr/local/bin/accept-all-ips
    - source: https://github.com/REMnux/distro/raw/master/files/accept-all-ips
    - source_hash: sha256=7015f700fa57c1cf1b278772d04241b83278798853f27e7d0f0c20483d025824
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.scripts.myip