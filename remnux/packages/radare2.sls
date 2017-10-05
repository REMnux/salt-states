# Source: https://github.com/radare/radare2
# Authors: https://github.com/radare/radare2/blob/master/AUTHORS.md

include:
  - remnux.packages.git

remnux-radare2-source:
  file.managed:
    - name: /usr/local/src/radare2-1.6.0.deb
    - source: http://radare.mikelloc.com/get/1.6.0/radare2_1.6.0_amd64.deb
    - source_hash: sha256=3d6319a7f4e8b60deacf6e367bd2421e283c225d0cbaa8c3633114654a142c4f

remnux-radare2:
  pkg.installed:
    - sources:
      - radare2: /usr/local/src/radare2-1.6.0.deb
    - watch:
      - file: remnux-radare2-source
    - require:
      - pkg: git

remnux-radare2-init:
  cmd.wait:
    - name: r2pm init
    - watch:
      - pkg: remnux-radare2

remnux-radare2-update:
  cmd.wait:
    - name: r2pm update
    - watch:
      - cmd: remnux-radare2-init
