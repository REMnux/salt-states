# Name: ioc_writer
# Website: https://github.com/mandiant/ioc_writer
# Description: Python library that allows for basic creation and editing of OpenIOC objects.
# Category: Library
# Author: William Gibb
# License: https://github.com/mandiant/ioc_writer/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip
  - remnux.python-packages.lxml

ioc_writer:
  pip.installed:
    - require:
      - pkg: python-pip
      - pip: lxml