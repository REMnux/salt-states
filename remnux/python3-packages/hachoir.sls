# Name: Hachoir
# Website: https://github.com/vstinner/hachoir
# Description: View, edit, and carve contents of various binary file types.
# Category: Examine Static Properties: General, Analyze Documents: Microsoft Office
# Author: https://hachoir.readthedocs.io/en/latest/authors.html
# License: GNU General Public License (GPL) v2: https://github.com/vstinner/hachoir/blob/master/COPYING
# Notes: hachoir-metadata, hachoir-grep, hachoir-strip, hachoir-urwid, hachoir-wx

include:
  - remnux.packages.python3-pip

remnux-python3-packages-hachoir:
  pip.installed:
    - name: hachoir
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip

python-hachoir-core:
  pkg.removed:
    - require:
      - pip: remnux-python3-packages-hachoir

python-hachoir-regex:
  pkg.removed:
    - require:
      - pip: remnux-python3-packages-hachoir

python-hachoir-wx:
  pkg.removed:
    - require:
      - pip: remnux-python3-packages-hachoir

python-urwid:
  pkg.removed:
    - require:
      - pip: remnux-python3-packages-hachoir