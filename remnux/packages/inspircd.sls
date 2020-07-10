# Name: inspircd 3
# Website: https://www.inspircd.org/
# Description: Examine IRC activity with this IRC server.
# Category: Explore Network Interactions: Services
# Author: InspIRCd Development Team
# License: GNU General Public License (GPL) v2: https://docs.inspircd.org/license/
# Notes: 

remnux-inspircd-source:
  file.managed:
    - name: /usr/local/src/inspircd_3.6.0-1_amd64.deb
    - source: https://github.com/inspircd/inspircd/releases/download/v3.6.0/inspircd_3.6.0-1_amd64.deb
    - source_hash: sha256=672b0f7630debc20f57d4bd06790d73636b152baf06b9602754c85a571ea469c

remnux-inspircd:
  pkg.installed:
    - sources:
      - inspircd: /usr/local/src/inspircd_3.6.0-1_amd64.deb
    - watch:
      - file: remnux-inspircd-source

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

inspircd-service:
  service.dead:
    - name: inspircd
    - enable: False
    - watch:
      - pkg: remnux-inspircd

{% endif %}
