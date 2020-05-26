# Name: peepdf
# Website: https://eternal-todo.com/tools/peepdf-pdf-analysis-tool
# Description: Tool to breakout components of a given PDF file
# Category: Examine document files: PDF
# Author: Jose Miguel Esparza
# License: https://github.com/jesparza/peepdf/blob/master/COPYING
# Notes: 

include:
  - remnux.packages.python-pip
  - remnux.packages.python-lxml
  - remnux.packages.libemu
  - remnux.packages.libjpeg8-dev
  - remnux.packages.zlib1g-dev
  - remnux.python-packages.pylibemu
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-thread-dev

remnux-peepdf:
  pip.installed:
    - name: peepdf
    - pip_bin: /usr/bin/python2
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python-lxml
      - sls: remnux.packages.libemu
      - sls: remnux.packages.libjpeg8-dev
      - sls: remnux.packages.zlib1g-dev
      - sls: remnux.python-packages.pylibemu
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-thread-dev
