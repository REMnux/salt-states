# Name: mbcscan
# Website: https://github.com/accidentalrebel/mbcscan
# Description: Scans a malware file and lists down the related MBC (Malware Behavior Catalog) details.
# Category: Examine Static Properties: PE Files
# Author: Karlo Licudine: https://twitter.com/accidentalrebel
# License: GNU General Public License (GPL) v3.0: https://github.com/accidentalrebel/mbcscan/blob/master/LICENSE
# Notes: mbcscan.py

include:
  - remnux.packages.git
  - remnux.packages.python3
  - remnux.python3-packages.pip

remnux-scripts-mbcscan-requirements:
  pip.installed:
    - bin_env: /usr/bin/python3
    - requirements: https://raw.githubusercontent.com/accidentalrebel/mbcscan/master/requirements.txt
    - require:
      - sls: remnux.python3-packages.pip

remnux-scripts-mbcscan-source:
  file.managed:
    - name: /usr/local/bin/mbcscan.py
    - source: https://raw.githubusercontent.com/accidentalrebel/mbcscan/master/mbcscan.py
    - source_hash: sha256=95e9054bbcc19c819df4347a005c70411e12e152dee3c69c1663569612d81ad8
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.python3
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.git
      - pip: remnux-scripts-mbcscan-requirements