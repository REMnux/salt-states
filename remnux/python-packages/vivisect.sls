# Name: Vivisect
# Website: https://github.com/vivisect/vivisect
# Description: Statically examine and emulate binary files.
# Category: Statically Analyze Code
# Author: invisigoth: invisigoth@kenshoto.com, Installable vivisect module by Willi Ballenthin: https://twitter.com/williballenthin
# License: https://github.com/vivisect/vivisect/blob/master/LICENSE.txt
# Notes: vivbin, vdbbin

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.packages.python-pyqt5
  - remnux.packages.python-pyqt5-qtwebkit

remnux-pip-vivisect:
  pip.installed:
    - name: https://github.com/williballenthin/vivisect/zipball/master
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python-pyqt5
      - sls: remnux.packages.python-pyqt5-qtwebkit
