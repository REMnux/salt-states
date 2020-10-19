# Name: ioc_writer
# Website: https://github.com/mandiant/ioc_writer
# Description: Python library that allows for basic creation and editing of OpenIOC objects.
# Category: Gather and Analyze Data
# Author: William Gibb
# License: Apache License 2.0: https://github.com/mandiant/ioc_writer/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python2-pip
  - remnux.python-packages.lxml
  - remnux.packages.python3-pip

ioc_writer:
  pip.installed:
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.python-packages.lxml
