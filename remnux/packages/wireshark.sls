# Name: wireshark
# Website: https://www.wireshark.org
# Description: Network traffic analyzer
# Category: Network Interactions: Sniffing
# Author: https://www.wireshark.org/about.html#authors
# License: https://www.wireshark.org/about.html#legal
# Notes: 

include:
  - remnux.repos.wireshark-dev

wireshark:
  pkg.installed:
    - pkgrepo: wireshark-dev