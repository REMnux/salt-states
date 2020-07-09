# Name: shodan
# Website: https://github.com/achillean/shodan-python/
# Description: Query Shodan, a search engine for internet-connected devices.
# Category: Gather and Analyze Data
# Author: John Matherly
# License: Custom, free license: https://github.com/achillean/shodan-python/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip

shodan:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
