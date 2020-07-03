# Name: xxxswf
# Website: https://github.com/viper-framework/xxxswf
# Description: Python script for analyzing Flash SWF files
# Category: Examine browser malware: Flash
# Author: Alexander Hanel
# License: https://github.com/viper-framework/xxxswf/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.python-packages.yara-python3
  - remnux.python-packages.pylzma-python3

remnux-python-packages-xxxswf:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/xxxswf.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python3-pip
      - sls: remnux.python-packages.yara-python3
      - sls: remnux.python-packages.pylzma-python3
