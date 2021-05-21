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

{%- if grains['oscodename'] == "focal" %}

remnux-python3-packages-vivisect-pyasn1-removal:
  pkg.removed:
    - pkgs:
      - python3-pyasn1
      - python3-pyasn1-modules

remnux-python3-packages-vivisect-cleanup1:
  module.run:
    - name: file.find
    - path: "/usr/lib/python3/dist-packages"
    - kwargs:
        iname: "PyYAML-*.egg-info"
        delete: "f"

remnux-python3-packages-vivisect-cleanup2:
  file.absent:
    - name: /usr/lib/python3/dist-packages/yaml
    - require:
      - module: remnux-python3-packages-vivisect-cleanup1

remnux-python3-packages-vivisect-cleanup3:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: pyyaml
    - require:
      - sls: remnux.python3-packages.pip
      - file: remnux-python3-packages-vivisect-cleanup2

remnux-python3-packages-vivisect:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: vivisect
    - require:
      - sls: remnux.python3-packages.pip
      - pip: remnux-python3-packages-vivisect-cleanup3

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
