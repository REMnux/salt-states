# Name: androguard
# Website: https://github.com/androguard/androguard
# Description: Examine Android files.
# Category: Statically Analyze Code: Android
# Author: Anthony Desnos, Geoffroy GueGuen
# License: Apache License 2.0: https://github.com/androguard/androguard/blob/master/LICENCE-2.0
# Notes: androarsc.py, androauto.py, androaxml.py, androcg.py, androdd.py, androdis.py, androguard, androgui.py, androlyze.py, androsign.py

include:
  - remnux.packages.python3-pyqt5
  - remnux.python3-packages.pip
  - remnux.python3-packages.pyperclip

remnux-python3-packages-androguard:
  pip.installed:
    - name: androguard
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pyqt5
      - sls: remnux.python3-packages.pip
      - sls: remnux.python3-packages.pyperclip
