# Name: peepdf
# Website: https://eternal-todo.com/tools/peepdf-pdf-analysis-tool
# Description: Examine elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Jose Miguel Esparza
# License: GNU General Public License (GPL) v3: https://github.com/jesparza/peepdf/blob/master/COPYING
# Notes: This state removes the python2 version of peepdf

include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip

remnux-tools-peepdf-remove:
  pip.removed:
    - name: peepdf
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip
