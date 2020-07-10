# Name: peepdf
# Website: https://eternal-todo.com/tools/peepdf-pdf-analysis-tool
# Description: Examine elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Jose Miguel Esparza
# License: GNU General Public License (GPL) v3: https://github.com/jesparza/peepdf/blob/master/COPYING
# Notes: 

include:
  - remnux.packages.python-pip
  - remnux.packages.libemu
  - remnux.packages.libjpeg8-dev
  - remnux.packages.zlib1g-dev
  - remnux.packages.git

remnux-tools-peepdf-source:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/peepdf.git
    - pip_bin: /usr/bin/python2
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.libemu
      - sls: remnux.packages.libjpeg8-dev
      - sls: remnux.packages.zlib1g-dev
      - sls: remnux.packages.git
