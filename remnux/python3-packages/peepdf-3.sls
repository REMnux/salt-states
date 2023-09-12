# Name: peepdf
# Website: https://eternal-todo.com/tools/peepdf-pdf-analysis-tool
# Description: Examine elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Jose Miguel Esparza and Corey Forman
# License: GNU General Public License (GPL) v3: https://github.com/digitalsleuth/peepdf-3/blob/main/COPYING
# Notes:

include:
  - remnux.packages.python3-pip
  - remnux.packages.libemu
  - remnux.packages.libjpeg8-dev
  - remnux.packages.zlib1g-dev
  - remnux.packages.git
  - remnux.python3-packages.stpyv8

remnux-tools-peepdf-3-source:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/peepdf-3.git
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.libemu
      - sls: remnux.packages.libjpeg8-dev
      - sls: remnux.packages.zlib1g-dev
      - sls: remnux.packages.git
      - sls: remnux.python3-packages.stpyv8
