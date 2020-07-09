# Name: PyPDNS
# Website: https://github.com/CIRCL/PyPDNS
# Description: Python library to query passive DNS services that follow the Passive DNS - Common Output Format
# Category: Gather and Analyze Data
# Author: Raphaël Vinot, Alexandre Dulaunoy, CIRCL - Computer Incident Response Center Luxembourg
# License: Free, custom license: https://github.com/CIRCL/PyPDNS/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip

pypdns:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
