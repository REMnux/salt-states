# Name: oledump
# Website: https://blog.didierstevens.com/programs/oledump-py/
# Description: Analyze OLE2 Structured Storage files.
# Category: Analyze Documents: Microsoft Office
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: oledump.py

include:
  - remnux.python3-packages.yara-python3
  - remnux.python3-packages.olefile
  - remnux.python3-packages.pyzipper
  - remnux.repos.remnux

remnux-packages-oledump:
  pkg.installed:
    - name: oledump
    - version: latest
    - upgrade: True
    - pkgrepo: remnux
    - require:
      - sls: remnux.python3-packages.yara-python3
      - sls: remnux.python3-packages.olefile
      - sls: remnux.python3-packages.pyzipper