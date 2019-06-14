# Source: https://github.com/unixfreak0037/officeparser
# Author: John Davison

remnux-scripts-officeparser:
  file.managed:
    - name: /usr/local/bin/officeparser.py
    - source: https://raw.githubusercontent.com/unixfreak0037/officeparser/master/officeparser.py
    - source_hash: sha256=101ef6590e274061475f8f8f4335148af9ba5f09ff16fb775558e6438c3d68bb
    - mode: 755
