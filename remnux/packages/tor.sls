# Name: tor
# Website: https://www.torproject.org/
# Description: Private browsing toolkit
# Category: Examine browser malware: Websites
# Author: 
# License: https://www.torproject.org/about/trademark/
# Notes: 

tor:
  pkg.installed

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

tor-service:
  service.dead:
    - name: tor
    - enable: False
    - watch:
      - pkg: tor

{% endif %}