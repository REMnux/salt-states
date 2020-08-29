# Name: officeparser
# Website: https://github.com/unixfreak0037/officeparser
# Description: Parse Microsoft Office OLE2 compound documents.
# Category: Analyze Documents: Microsoft Office
# Author: John William Davison
# License: MIT License: https://github.com/unixfreak0037/officeparser/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

officeparser:
  pip.installed:
    - bin_env: /usr/bin/python
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip
