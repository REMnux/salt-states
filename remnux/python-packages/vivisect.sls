# Name: Vivisect
# Website: https://github.com/vivisect/vivisect
# Description: Statically examine and emulate binary files. (Only on Ubuntu 18.04.)
# Category: Statically Analyze Code: General
# Author: invisigoth: invisigoth@kenshoto.com, installable vivisect module by Willi Ballenthin: https://twitter.com/williballenthin
# License: Apache License 2.0: https://github.com/vivisect/vivisect/blob/master/LICENSE.txt
# Notes: Vivisect is presently only installed when REMnux is running on Ubuntu 18.04, because some of its dependencies aren't available on Ubuntu 20.04. If the tool is installed, you can inoke it using commands `vivbin` and `vdbbin`.

{%- if grains['oscodename'] == "bionic" %}

include:
  - remnux.packages.git
  - remnux.packages.python2-pip
  - remnux.packages.python-pyqt5
  - remnux.packages.python-pyqt5-qtwebkit
  - remnux.packages.python3-pip

remnux-pip-vivisect:
  pip.installed:
    - bin_env: /usr/bin/python2
    - name: https://github.com/williballenthin/vivisect/zipball/master
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.python-pyqt5
      - sls: remnux.packages.python-pyqt5-qtwebkit

{%- endif %}