# Name: wireshark
# Website: https://www.wireshark.org
# Description: Capture and analyze network traffic with this sniffer.
# Category: Explore Network Interactions
# Author: https://www.wireshark.org/about.html#authors
# License: https://www.wireshark.org/about.html#legal
# Notes: 

include:
  - remnux.repos.wireshark-dev

wireshark:
  pkg.installed:
    - pkgrepo: wireshark-dev