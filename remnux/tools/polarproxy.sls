# Name: PolarProxy
# Website: https://www.netresec.com/
# Description: Intercept and decrypt TLS traffic.
# Category: Explore Network Interactions: Monitoring
# Author: NETRESEC AB
# License: Creative Commons Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0) License: https://www.netresec.com/?page=PolarProxy
# Notes: polarproxy

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}
{# arm64 extracts to its own directory, so an x86 PolarProxy left by an earlier install is never reused #}
{% set file = 'PolarProxy_2.0.2_linux-arm64.tar.gz' %}
{% set dir = '/usr/local/polarproxy-2.0.2-arm64' %}

remnux-polarproxy-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ file }}
    - source: https://download.netresec.com/polarproxy/{{ file }}
    - source_hash: sha256=f972583a2df80283bd3321737c0a14585467dea0a967d47305490f1c97c09081
    - makedirs: True

remnux-polarproxy-archive:
  archive.extracted:
    - name: {{ dir }}
    - source: /usr/local/src/remnux/files/{{ file }}
    - enforce_toplevel: False
    - require:
      - file: remnux-polarproxy-source

remnux-polarproxy-binary:
  file.managed:
    - name: {{ dir }}/PolarProxy
    - mode: 755
    - replace: False
    - require:
      - archive: remnux-polarproxy-archive

remnux-polarproxy-wrapper:
  file.managed:
    - name: /usr/local/bin/polarproxy
    - mode: 755
    - require:
      - file: remnux-polarproxy-binary
    - contents:
      - '#!/bin/bash'
      - {{ dir }}/PolarProxy ${*}

{% else %}

remnux-polarproxy-source:
  file.managed:
    - name: /usr/local/src/remnux/files/PolarProxy_2.0.2_linux-x64.tar.gz
    - source: https://download.netresec.com/polarproxy/PolarProxy_2.0.2_linux-x64.tar.gz
    - source_hash: sha256=d5edfceebfd6aa5991a0ff832fa1a558d083398569d0f380aa22637efb14d89a
    - makedirs: True
    - replace: False

remnux-polarproxy-archive:
  archive.extracted:
    - name: /usr/local/polarproxy/
    - source: /usr/local/src/remnux/files/PolarProxy_2.0.2_linux-x64.tar.gz
    - enforce_toplevel: False
    - force: true
    - watch:
      - file: remnux-polarproxy-source

/usr/local/polarproxy/PolarProxy:
  file.managed:
    - mode: 755
    - replace: False
    - watch:
      - archive: remnux-polarproxy-archive

remnux-polarproxy-wrapper:
  file.managed:
    - name: /usr/local/bin/polarproxy
    - mode: 755
    - replace: False
    - watch:
      - file: /usr/local/polarproxy/PolarProxy
    - contents:
      - '#!/bin/bash'
      - /usr/local/polarproxy/PolarProxy ${*}

{% endif %}
