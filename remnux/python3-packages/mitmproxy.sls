# Name: mitmproxy
# Website: https://mitmproxy.org/
# Description: Investigate website interactions using this web proxy.
# Category: Explore Network Interactions: Monitoring
# Author: https://github.com/orgs/mitmproxy/people
# License: MIT License: https://github.com/mitmproxy/mitmproxy/blob/master/LICENSE
# Notes: mitmproxy, mitmdump, mitmweb

remnux-mitmproxy-source:
  file.managed.:
    - name: /usr/local/src/remnux/files/mitmproxy-5.1.1-linux.tar.gz
    - source: https://snapshots.mitmproxy.org/5.1.1/mitmproxy-5.1.1-linux.tar.gz
    - source_hash: sha256=f7db3439abdce411ca8f0125bdcc2a3d8923487b79fc3d57ee15aa0ba21ffdc0
    - makedirs: True

remnux-mitmproxy-archive:
  archive.extracted:
    - name: /usr/local/bin/
    - source: /usr/local/src/remnux/files/mitmproxy-5.1.1-linux.tar.gz
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
