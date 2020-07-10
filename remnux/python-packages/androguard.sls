# Name: androguard
# Website: https://github.com/androguard/androguard
# Description: Examine Android files.
# Category: Statically Analyze Code: Android
# Author: Anthony Desnos, Geoffroy GueGuen
# License: Apache License 2.0: https://github.com/androguard/androguard/blob/master/LICENCE-2.0
# Notes: androarsc.py, androauto.py, androaxml.py, androcg.py, androdd.py, androdis.py, androguard, androgui.py, androlyze.py, androsign.py

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.python3-pyqt5
  - remnux.python-packages.pyperclip

remnux-python-androguard:
  pip.installed:
    - name: androguard
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python3-pyqt5
      - sls: remnux.python-packages.pyperclip      
