# Name: officeparser
# Website: https://github.com/unixfreak0037/officeparser
# Description: Python2 script to parse OLE compound documents
# Category: Examine document files: Microsoft Office
# Author: John Davison
# License: https://github.com/unixfreak0037/officeparser/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip

officeparser:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
