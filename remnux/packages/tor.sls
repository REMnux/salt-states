# Name: tor
# Website: https://www.torproject.org/
# Description: Private browsing toolkit
# Category: Examine browser malware: Websites
# Author: 
# License: https://www.torproject.org/about/trademark/
# Notes: 

tor:
  pkg.installed

tor-service:
  service.dead:
    - enable: False
    - watch:
      - pkg: tor
