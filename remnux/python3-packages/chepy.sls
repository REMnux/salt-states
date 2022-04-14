# Name: Chepy
# Website: https://github.com/securisec/chepy
# Description: Decode and otherwise analyze data using this command-line tool and Python library.
# Category: Examine Static Properties: Deobfuscation
# Author: Hapsida Securisec: https://twitter.com/securisec
# License: GNU General Public License (GPL) v3: https://github.com/securisec/chepy/blob/master/LICENSE
# Notes: chepy

include:
  - remnux.python3-packages.pip
  - remnux.python3-packages.pycryptodome

remnux-python3-packages-chepy:
  pip.installed:
    - name: chepy
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip    
      - sls: remnux.python3-packages.pycryptodome

remnux-python3-packages-chepy-extras:
  pip.installed:
    - name: chepy[extras]
    - bin_env: /usr/bin/python3
    - upgrade: True
    - watch:
      - pip: remnux-python3-packages-chepy
