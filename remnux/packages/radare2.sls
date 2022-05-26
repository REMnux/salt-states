# Name: radare2
# Website: https://www.radare.org/n/radare2.html
# Description: Examine binary files, including disassembling and debugging.
# Category: Dynamically Reverse-Engineer Code: General
# Author: https://github.com/radareorg/radare2/blob/master/AUTHORS.md
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/radareorg/radare2/blob/master/COPYING
# Notes: r2, rasm2, rabin2, rahash2, rafind2
{% set version = '5.6.8' %}
{% set hash = '7af2fa605f00e1ae740db7dba2c0b8bc6c44e2eea3027cc7795ec46bf0292d2e' %}

include:
  - remnux.packages.git

remnux-radare2-source:
  file.managed:
    - name: /usr/local/src/radare2_{{ version }}_amd64.deb
    - source: https://github.com/radareorg/radare2/releases/download/{{ version }}/radare2_{{ version }}_amd64.deb
    - source_hash: sha256={{ hash }}

remnux-radare2:
  pkg.installed:
    - sources:
      - radare2: /usr/local/src/radare2_{{ version }}_amd64.deb
    - watch:
      - file: remnux-radare2-source
    - require:
      - pkg: git

remnux-radare2-cleanup:
  pkg.removed:
    - name: libradare2-common
    - require:
      - pkg: remnux-radare2

remnux-radare2-init:
  cmd.wait:
    - name: r2pm init
    - watch:
      - pkg: remnux-radare2-cleanup

remnux-radare2-update:
  cmd.wait:
    - name: r2pm update
    - watch:
      - cmd: remnux-radare2-init
