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
    - source_hash: sha256=a7e438fcebd5ba5f77b70cad5c198fdb6e107276d1e22dbf7a1164409cd91e53
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.python3
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.git
      - pip: remnux-scripts-mbcscan-requirements