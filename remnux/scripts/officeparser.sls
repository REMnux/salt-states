# Source: https://github.com/unixfreak0037/officeparser
# Author: John Davison

remnux-scripts-officeparser:
  file.managed:
    - name: /usr/local/bin/officeparser.py
    - source: https://raw.githubusercontent.com/unixfreak0037/officeparser/master/officeparser.py
    - mode: 755
    - skip_verify: True
