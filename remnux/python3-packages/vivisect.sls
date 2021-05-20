# Name: Vivisect
# Website: https://github.com/vivisect/vivisect
# Description: Statically examine and emulate binary files.
# Category: Statically Analyze Code: General
# Author: invisigoth: invisigoth@kenshoto.com, installable vivisect module by Willi Ballenthin: https://twitter.com/williballenthin
# License: Apache License 2.0: https://github.com/vivisect/vivisect/blob/master/LICENSE.txt
# Notes: vivbin, vdbbin.

include:
  - remnux.packages.python2-pip
  - remnux.python3-packages.pip

{%- if grains['oscodename'] == "focal" %}

remnux-python3-packages-vivisect-cleanup1:
  file.absent:
    - name: /usr/lib/python3/dist-packages/PyYAML-5.3.1.egg-info

remnux-python3-packages-vivisect-cleanup2:
  file.absent:
    - name: /usr/lib/python3/dist-packages/yaml
    - require:
      - file: remnux-python3-packages-vivisect-cleanup1


remnux-python3-packages-vivisect:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: vivisect
    - require:
      - sls: remnux.python3-packages.pip
      - file: remnux-python3-packages-vivisect-cleanup2

remnux-python3-packages-vivisect-cleanup3:
  pkg.installed:
    - name: python3-yaml
    - reinstall: True
    - require:
      - pip: remnux-python3-packages-vivisect

{%- else %}

remnux-python3-packages-vivisect:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: vivisect
    - require:
      - sls: remnux.python3-packages.pip

{%- endif %}

remnux-python3-packages-vivisect-cleanup:
  pip.removed:
    - bin_env: /usr/bin/python2
    - name: vivisect
    - require:
      - sls: remnux.packages.python2-pip