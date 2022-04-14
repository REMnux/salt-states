# Name: PEframe
# Website: https://github.com/digitalsleuth/peframe
# Description: Statically analyze PE and Microsoft Office files.
# Category: Examine Static Properties: PE Files
# Author: Gianni Amato: https://twitter.com/guelfoweb
# License: Free, unknown license
# Notes: peframe

include:
  - remnux.packages.libssl-dev
  - remnux.packages.swig
  - remnux.python3-packages.pip

remnux-python3-packages-peframe-remove:
  pip.removed:
    - name: peframe
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip

remnux-python3-packages-peframe:
  pip.installed:
    - name: peframe-ds
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.swig
      - sls: remnux.python3-packages.pip
