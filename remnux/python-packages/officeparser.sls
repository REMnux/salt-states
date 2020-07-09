# Name: officeparser
# Website: https://github.com/unixfreak0037/officeparser
# Description: Parse Microsoft Office OLE2 compound documents.
# Category: Analyze Documents: Microsoft Office
# Author: John William Davison
# License: MIT License: https://github.com/unixfreak0037/officeparser/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip

officeparser:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
