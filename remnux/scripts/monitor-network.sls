# Name: monitor-network
# Website: https://github.com/REMnux/distro/blob/master/files/monitor-network
# Description: Monitor traffic on the first active network interface using tshark, printing a live summary to the screen or saving it to a pcapng file.
# Category: Explore Network Interactions: Monitoring
# Author: Lenny Zeltser
# License: Public Domain
# Notes: monitor-network [filename]

include:
  - remnux.scripts.mynic
  - remnux.packages.tshark

remnux-scripts-monitor-network-source:
  file.managed:
    - name: /usr/local/bin/monitor-network
    - source: https://github.com/REMnux/distro/raw/master/files/monitor-network
    - source_hash: sha256=70c8189c86946473f8c4d57002c8c5710775a858875657ee1a3cd078fbfda70f
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.scripts.mynic
      - sls: remnux.packages.tshark
