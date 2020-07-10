# Name: tor
# Website: https://www.torproject.org
# Description: Obfuscate your origins by routing traffic through a network of anonymizing nodes.
# Category: Explore Network Interactions: Connecting
# Author: Roger Dingledine, Nick Mathewson, Tor Project Inc.
# License: 3-Clause BSD license: https://github.com/torproject/tor/blob/master/LICENSE
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