# Name: inspircd 3
# Website: https://www.inspircd.org/
# Description: Examine IRC activity with this IRC server.
# Category: Explore Network Interactions: Services
# Author: InspIRCd Development Team
# License: GNU General Public License (GPL) v2: https://docs.inspircd.org/license/
# Notes:

{% from "remnux/osarch.sls" import osarch with context %}
{% set os_rel = '24.04.2' %}
{% set version = '4.7.0' %}
{% set hash = '357dedd08a446f83f5327ac04694de65982ed2a2a457c4b9611e4e26109795e7' %}

include:
  - remnux.packages.libpq5
  - remnux.packages.libre2
  - remnux.packages.libtre5
  - remnux.packages.gnutls-bin
  - remnux.packages.libmysqlclient21

{% if osarch == "arm64" %}
{# InspIRCd publishes amd64 packages only, so arm64 installs Ubuntu's inspircd package #}

remnux-packages-inspircd-install:
  pkg.installed:
    - name: inspircd
    - require:
      - sls: remnux.packages.libpq5
      - sls: remnux.packages.libre2
      - sls: remnux.packages.libtre5
      - sls: remnux.packages.gnutls-bin
      - sls: remnux.packages.libmysqlclient21

{% else %}

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
      - sls: remnux.packages.libmysqlclient21
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
