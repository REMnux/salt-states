# Name: inspircd 3
# Website: https://www.inspircd.org/
# Description: Examine IRC activity with this IRC server.
# Category: Explore Network Interactions: Services
# Author: InspIRCd Development Team
# License: GNU General Public License (GPL) v2: https://docs.inspircd.org/license/
# Notes: 


{% set version = '3.15.0' %}
{%- if grains['oscodename'] == "focal" %}
  {% set os_rel = '20.04.3' %}
  {% set hash = '2d98e442c4a2a9a59bda10729eb8aac31444f5fedb58fcc65d23d415e03e7c2f' %}
{% elif grains['oscodename'] == "bionic" %}
  {% set os_rel = '18.04.3' %}
  {% set hash = 'b3dec6e276446dbf17dde874433f73bfec1e45a3e601835dab6aeef17c94c380' %}
{% endif %}

include:
  - remnux.packages.libpq5
  - remnux.packages.libre2
  - remnux.packages.libtre5
  - remnux.packages.gnutls-bin
{% if grains['oscodename'] == "bionic" %}
  - remnux.packages.perl
  - remnux.packages.libargon2-0
  - remnux.packages.libmysqlclient20
  - remnux.packages.libpcre2-8-0
  - remnux.packages.libio-socket-ssl-perl
{% endif %}

remnux-packages-inspircd-source:
  file.managed:
    - name: /usr/local/src/inspircd_{{ version }}.ubuntu{{ os_rel }}_amd64.deb
    - source: https://github.com/inspircd/inspircd/releases/download/v{{ version }}/inspircd_{{ version }}.ubuntu{{ os_rel }}_amd64.deb
    - source_hash: sha256={{ hash }}

remnux-packages-inspircd-install:
  pkg.installed:
    - sources:
      - inspircd: /usr/local/src/inspircd_{{ version }}.ubuntu{{ os_rel }}_amd64.deb
    - require:
      - sls: remnux.packages.libpq5
      - sls: remnux.packages.libre2
      - sls: remnux.packages.libtre5
      - sls: remnux.packages.gnutls-bin
{% if grains['oscodename'] == "bionic" %}
      - sls: remnux.packages.perl
      - sls: remnux.packages.libargon2-0
      - sls: remnux.packages.libmysqlclient20
      - sls: remnux.packages.libpcre2-8-0
      - sls: remnux.packages.libio-socket-ssl-perl
{% endif %}
    - watch:
      - file: remnux-packages-inspircd-source

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
