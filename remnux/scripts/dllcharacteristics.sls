# Name: dllcharacteristics.py
# Website: https://github.com/accidentalrebel/dllcharacteristics.py
# Description: A simple Python tool for getting and setting the values of DLL characteristics for PE files.
# Category: View or Edit Files, Examine Static Properties: General
# Author: Karlo Licudine: https://twitter.com/accidentalrebel
# License: GNU General Public License (GPL) v3.0: https://github.com/accidentalrebel/dllcharacteristics.py/blob/master/LICENSE
# Notes: 

include:
  - remnux.python3-packages.pefile
  - remnux.packages.python3

remnux-scripts-dllcharacteristics-source:
  file.managed:
    - name: /usr/local/bin/dllcharacteristics.py
    - source: https://raw.githubusercontent.com/accidentalrebel/dllcharacteristics.py/master/dllcharacteristics.py
    - source_hash: sha256=b0f8ebb322954f44c784bb70bf500a093b067d7a68022be8e77046e5d83bba09
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.python3-packages.pefile
      - sls: remnux.packages.python3
