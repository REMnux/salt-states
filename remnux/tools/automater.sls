# Source: https://github.com/1aN0rmus/TekDefense-Automater
# Author: 1aN0rmus / TekDefense

include:
  - remnux.packages.git

remnux-tools-automater:
  git.cloned:
    - name: https://github.com/1aN0rmus/TekDefense-Automater
    - target: /usr/local/automater
    - user: root
    - branch: master

remnux-tools-automater-binary:
  file.managed:
    - replace: False
    - name: /usr/local/automater/Automater.py
    - mode: 755
    - watch:
      - git: remnux-tools-automater

