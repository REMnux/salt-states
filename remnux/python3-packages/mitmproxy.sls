# Name: mitmproxy
# Website: https://mitmproxy.org/
# Description: Investigate website interactions using this web proxy.
# Category: Explore Network Interactions: Monitoring
# Author: https://github.com/orgs/mitmproxy/people
# License: MIT License: https://github.com/mitmproxy/mitmproxy/blob/master/LICENSE
# Notes: mitmproxy, mitmdump, mitmweb

remnux-mitmproxy-source:
  file.managed.:
    - name: /usr/local/src/remnux/files/mitmproxy-6.0.2-linux.tar.gz
    - source: http://snapshots.mitmproxy.org/6.0.2/mitmproxy-6.0.2-linux.tar.gz
    - source_hash: sha256=86e96c9a6f50f2863e69dcdfe91c38b4f0844ee1ab0037373689db8aaacb5191
    - makedirs: True

remnux-mitmproxy-archive:
  archive.extracted:
    - name: /usr/local/bin/
    - source: /usr/local/src/remnux/files/mitmproxy-6.0.2-linux.tar.gz
    - enforce_toplevel: False
    - force: True
    - watch:
      - file: remnux-mitmproxy-source

remnux-mitmproxy-files:
  file.managed:
    - replace: False
    - names:
      - /usr/local/bin/mitmproxy
      - /usr/local/bin/mitmdump
      - /usr/local/bin/mitmweb
    - mode: 755
    - watch:
      - archive: remnux-mitmproxy-archive
