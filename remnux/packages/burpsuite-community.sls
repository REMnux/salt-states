# Name: Burp Suite Community Edition
# Website: https://portswigger.net
# Description: Investigate website interactions using this web proxy.
# Category: Explore Network Interactions: Monitoring
# Author: PortSwigger
# License: Free, custom license: https://portswigger.net/burp/tc-community
# Notes: burpsuite

include:
  - remnux.repos.remnux

remnux-packages-burpsuite-community:
  pkg.installed:
    - name: burpsuite-community
    - version: latest
    - upgrade: True
    - pkgrepo: remnux