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
  - remnux.packages.git

{%- if grains['oscodename'] == "focal" %}

remnux-python3-packages-capa-yaml:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: pyyaml
    - ignore_installed: True
    - require:
      - sls: remnux.python3-packages.pip

remnux-python3-packages-capa:
  pip.installed:
    - name: flare-capa
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - pip: remnux-python3-packages-capa-yaml

{%- else %}

remnux-python3-packages-capa:
  pip.installed:
    - name: flare-capa
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip

{%- endif %}

remnux-python3-packages-capa-cleanup:
  pkg.removed:
    - name: capa
    - require:
      - pip: remnux-python3-packages-capa

remnux-python3-packages-capa-rules1:
  git.cloned:
    - name: https://github.com/fireeye/capa-rules.git
    - target: /usr/local/share/capa-rules
    - user: root
    - branch: master
    - require:
      - pip: remnux-python3-packages-capa

remnux-python3-packages-capa-rules2:
  file.absent:
    - name: /usr/local/share/capa-rules/.git
    - require:
      - git: remnux-python3-packages-capa-rules1