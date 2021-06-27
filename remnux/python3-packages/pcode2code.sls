# Name: pcode2code
# Website: https://github.com/Big5-sec/pcode2code
# Description: Decompile VBA macro p-code from Microsoft Office documents
# Category: Analyze Documents: Microsoft Office
# Author: Nicolas Zilio: https://twitter.com/Big5_sec
# License: GNU General Public License (GPL) v3: https://github.com/Big5-sec/pcode2code/blob/master/LICENSE
# Notes: 

include:
  - remnux.python3-packages.pip

remnux-python3-packages-pcode2code:
  pip.installed:
    - name: pcode2code
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip