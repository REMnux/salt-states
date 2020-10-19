# Name: fakedns
# Website: https://code.activestate.com/recipes/491264-mini-fake-dns-server/
# Description: Respond to DNS queries with the specified IP address.
# Category: Explore Network Interactions: Services
# Author: Francisco Santos, modifications by Kevin Murray
# License: Free, unknown license
# Notes: 

include:
  - remnux.packages.python2

remnux-tools-fakedns-source:
  file.managed:
    - name: /usr/local/src/remnux/files/fakedns.py
    - source: https://github.com/REMnux/distro/raw/master/files/fakedns.py
    - source_hash: d0c387f60b0a8326591c3a6f2d5bd59503d833e99f9c50bc6ac841b4b173bdc6
    - makedirs: True
    - require:
        - sls: remnux.packages.python2

remnux-tools-fakedns-binary:
  file.managed:
    - name: /usr/local/bin/fakedns
    - source: /usr/local/src/remnux/files/fakedns.py
    - mode: 755
    - watch:
        - file: remnux-tools-fakedns-source

remnux-tools-fakedns-shebang:
  file.replace:
    - name: /usr/local/bin/fakedns
    - pattern: '#!/usr/bin/python\n'
    - repl: '#!/usr/bin/env python2\n'
    - count: 1
    - require:
      - file: remnux-tools-fakedns-binary
