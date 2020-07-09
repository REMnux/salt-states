# Name: tor
# Website: https://www.torproject.org
# Description: Obfuscate your origins by routing traffic through a network of anonymizing nodes.
# Category: Explore Network Interactions
# Author: Tor Project, Inc.
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