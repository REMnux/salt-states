# Name: pytesseract
# Website: https://github.com/madmaze/pytesseract
# Description: Examine images to identify and extract text using optical character recognition (OCR).
# Category: Analyze Documents
# Author: Matthias A Lee
# License: Apache License 2.0: https://github.com/madmaze/pytesseract/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python3-pip
  - remnux.packages.python3
  - remnux.packages.python-pip

remnux-pytesseract:
  pip.installed:
    - name: pytesseract
    - bin_env: /usr/bin/pip3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python-pip