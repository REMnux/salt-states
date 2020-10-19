# Name: xxxswf
# Website: https://github.com/viper-framework/xxxswf
# Description: Analyze Flash SWF files.
# Category: Statically Analyze Code: Flash
# Author: Alexander Hanel
# License: GNU General Public License (GPL) v3.0: https://github.com/viper-framework/xxxswf/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.git
  - remnux.packages.python3-pip
  - remnux.python3-packages.yara-python3
  - remnux.python3-packages.pylzma

remnux-python3-packages-xxxswf:
  pip.installed:
    - name: git+https://github.com/viper-framework/xxxswf.git
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python3-pip
      - sls: remnux.python3-packages.yara-python3
      - sls: remnux.python3-packages.pylzma
