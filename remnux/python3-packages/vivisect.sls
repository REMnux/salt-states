# Name: Vivisect
# Website: https://github.com/vivisect/vivisect
# Description: Statically examine and emulate binary files.
# Category: Statically Analyze Code: General
# Author: invisigoth: invisigoth@kenshoto.com, installable vivisect module by Willi Ballenthin: https://twitter.com/williballenthin
# License: Apache License 2.0: https://github.com/vivisect/vivisect/blob/master/LICENSE.txt
# Notes: vivbin, vdbbin

include:
  - remnux.packages.python2-pip
  - remnux.python3-packages.pip

remnux-python3-packages-vivisect-pyqt:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: PyQtWebEngine
    - ignore_installed: True
    - require:
      - sls: remnux.python3-packages.pip

{%- if grains['oscodename'] == "focal" %}

remnux-python3-packages-vivisect-pyasn1-removal:
  pkg.removed:
    - pkgs:
      - python3-pyasn1
      - python3-pyasn1-modules

remnux-python3-packages-vivisect:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: vivisect
    - require:
      - pip: remnux-python3-packages-vivisect-pyqt
      - pkg: remnux-python3-packages-vivisect-pyasn1-removal

{%- else %}

remnux-python3-packages-vivisect:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: vivisect
    - require:
      - pip: remnux-python3-packages-vivisect-pyqt

{%- endif %}

remnux-python3-packages-vivisect-cleanup:
  pip.removed:
    - bin_env: /usr/bin/python2
    - name: vivisect
    - require:
      - sls: remnux.packages.python2-pip
