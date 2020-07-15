# Name: oledump
# Website: https://blog.didierstevens.com/programs/oledump-py/
# Description: Analyze OLE2 Structured Storage files.
# Category: Analyze Documents: Microsoft Office
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: oledump.py

include:
  - remnux.python-packages.yara-python
  - remnux.python-packages.olefile
  - remnux.repos.remnux

oledump:
  pkg.installed:
    - pkgrepo: remnux
    - require:
      - sls: remnux.python-packages.yara-python
      - sls: remnux.python-packages.olefile