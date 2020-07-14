# Name: accept-all-ips
# Website: https://github.com/REMnux/distro/blob/master/files/accept-all-ips
# Description: Accept connections to all IPv4 and IPv6 addresses and redirect it to the corresponding local port.
# Category: Explore Network Interactions: Services
# Author: Lenny Zeltser, with input from the community
# License: GNU General Public License (GPL) v3+
# Notes: accept-all-ips <start|stop>

include:
  - remnux.scripts.mynic
  - remnux.packages.iptables

remnux-scripts-accept-all-ips-source:
  file.managed:
    - name: /usr/local/bin/accept-all-ips
    - source: https://github.com/REMnux/distro/raw/master/files/accept-all-ips
    - source_hash: sha256=de331c34a0e9f152bf96b9cee73907590f7a2416524c11a9c357415def50cee9
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.scripts.mynic
      - sls: remnux.packages.iptables