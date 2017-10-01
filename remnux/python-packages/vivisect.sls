# Source: https://github.com/vivisect/vivisect
# Author: invisig0th
# Comments: Installable vivisect module by Willi Ballenthin

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.packages.python-qt4

remnux-pip-vivisect:
  pip.installed:
    - name: https://github.com/williballenthin/vivisect/zipball/master
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python-qt4
