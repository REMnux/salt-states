# Name: capa
# Website: https://github.com/fireeye/capa
# Description: Detect suspicious capabilites in PE files.
# Category: Statically Analyze Code: PE Files
# Author: FireEye Inc, Willi Ballenthin: https://twitter.com/williballenthin, Moritz Raabe: https://twitter.com/m_r_tz
# License: Apache License 2.0: https://github.com/fireeye/capa/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.python3-packages.pip
  - remnux.python3-packages.vivisect

remnux-python3-packages-capa-cleanup1:
  file.absent:
    - name: /usr/lib/python3/dist-packages/PyYAML-5.3.1.egg-info
    - require:
      - sls: remnux.python3-packages.vivisect

remnux-python3-packages-capa-cleanup2:
  file.absent:
    - name: /usr/lib/python3/dist-packages/yaml
    - require:
      - file: remnux-python3-packages-capa-cleanup1

remnux-python3-packages-capa:
  pip.installed:
    - name: flare-capa
    - bin_env: /usr/bin/python3
    - require:
      - file: remnux-python3-packages-capa-cleanup2

remnux-python3-packages-capa-cleanup3:
  pkg.removed:
    - name: capa
    - require:
      - pip: remnux-python3-packages-capa