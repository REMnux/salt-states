# Name: pytesseract
# Website: https://github.com/madmaze/pytesseract
# Description: Python wrapper for Google Tesseract (OCR)
# Category: Examine browser malware: Websites
# Author: Matthias A Lee
# License: https://github.com/madmaze/pytesseract/blob/master/LICENSE
# Notes: Requirement/enhancement for thug

include:
  - remnux.packages.python3-pip
  - remnux.packages.python3

remnux-pytesseract:
  cmd.run:
    - name: /usr/bin/pip3 install --upgrade pytesseract
    - require:
      - sls: remnux.packages.python3-pip
