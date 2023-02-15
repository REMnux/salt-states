# Name: PolarProxy
# Website: https://www.netresec.com/
# Description: Intercept and decrypt TLS traffic.
# Category: Explore Network Interactions: Monitoring
# Author: NETRESEC AB
# License: Creative Commons Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0) License: https://www.netresec.com/?page=PolarProxy
# Notes: polarproxy

remnux-polarproxy-source:
  file.managed:
    - name: /usr/local/src/remnux/files/PolarProxy_0-9-8_linux-x64.tar.gz
    - source: https://www.netresec.com/?download=PolarProxy
    - source_hash: sha256=60b9fd9787a439070f51d1abb0db989a01c4f2fc241f6060165e5da6586d4f05
    - makedirs: True
    - replace: False

remnux-polarproxy-archive:
  archive.extracted:
    - name: /usr/local/polarproxy/
    - source: /usr/local/src/remnux/files/PolarProxy_0-9-8_linux-x64.tar.gz
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
