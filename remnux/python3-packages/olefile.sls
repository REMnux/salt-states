# Name: olefile
# Website: https://github.com/decalage2/olefile
# Description: Python package to parse, read and write MS OLE2 files.
# Category: Analyze Documents: Microsoft Office
# Author: Philippe Lagadec
# License: All Rights Reserved (https://github.com/decalage2/olefile/blob/master/LICENSE.txt)
# Notes: 

{% if grains['oscodename'] == 'focal' %}
include:
  - remnux.python3-packages.pip

remnux-python3-packages-olefile:
  pip.installed:
    - name: olefile
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip

{% else %}

remnux-python3-packages-olefile-package:
  pkg.installed:
    - name: python3-olefile

{% endif %}
