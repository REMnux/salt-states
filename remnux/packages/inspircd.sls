# Name: inspircd 3
# Website: https://www.inspircd.org/
# Description: Examine IRC activity with this IRC server.
# Category: Explore Network Interactions: Services
# Author: InspIRCd Development Team
# License: GNU General Public License (GPL) v2: https://docs.inspircd.org/license/
# Notes: 

{%- if grains['oscodename'] == "bionic" %}

remnux-packages-inspircd-source:
  file.managed:
    - name: /usr/local/src/inspircd_3.8.1.ubuntu18.04.1_amd64.deb
    - source: https://github.com/inspircd/inspircd/releases/download/v3.8.1/inspircd_3.8.1.ubuntu18.04.1_amd64.deb
    - source_hash: sha256=d993a9333395826d1312c940ef72e53c5d67217f481c08c2b00709352bdcae8f

remnux-packages-inspircd-install:
  pkg.installed:
    - sources:
      - inspircd: /usr/local/src/inspircd_3.8.1.ubuntu18.04.1_amd64.deb
    - watch:
      - file: remnux-packages-inspircd-source

{%- elif grains['oscodename'] == "focal" %}

remnux-packages-inspircd-source:
  file.managed:
    - name: /usr/local/src/inspircd_3.8.1.ubuntu20.04.1_amd64.deb
    - source: https://github.com/inspircd/inspircd/releases/download/v3.8.1/inspircd_3.8.1.ubuntu20.04.1_amd64.deb
    - source_hash: sha256=62cdd3dc915135ef4331b384217475ed0a4421198a02398efe1e016877c8c8dd

remnux-packages-inspircd-install:
  pkg.installed:
    - sources:
      - inspircd: /usr/local/src/inspircd_3.8.1.ubuntu20.04.1_amd64.deb
    - watch:
      - file: remnux-packages-inspircd-source

{% endif %}

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

inspircd-service:
  service.dead:
    - name: inspircd
    - enable: False
    - watch:
      - pkg: remnux-packages-inspircd-install

{% endif %}
