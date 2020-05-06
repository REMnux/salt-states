# Source: https://github.com/1aN0rmus/TekDefense-Automater
# Author: 1aN0rmus / TekDefense

include:
  - remnux.packages.git

remnux-tools-automater:
  git.latest:
    - name: https://github.com/1aN0rmus/TekDefense-Automater
    - target: /usr/local/automater
    - user: root
    - branch: master
    - force_fetch: True
    - force_checkout: True
    - force_clone: True
    - force_reset: True

remnux-tools-automater-binary:
  file.managed:
    - replace: False
    - name: /usr/local/automater/Automater.py
    - mode: 755
    - watch:
      - git: remnux-tools-automater

