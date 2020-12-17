# Name: fakedns
# Website: https://github.com/REMnux/distro/blob/master/files/fakedns.py
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
    - source_hash: 5a6d50b560eaf281f0f9ef4fe7ee33832c2c069ebb580cc02465748630ae923a
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