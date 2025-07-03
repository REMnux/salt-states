# Name: radare2
# Website: https://www.radare.org/n/radare2.html
# Description: Examine binary files, including disassembling and debugging.
# Category: Dynamically Reverse-Engineer Code: General
# Author: https://github.com/radareorg/radare2/blob/master/AUTHORS.md
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/radareorg/radare2/blob/master/COPYING
# Notes: r2, rasm2, rabin2, rahash2, rafind2
{% from "remnux/osarch.sls" import osarch with context %}
{% set version = '5.9.0' %}
{% set hash = '7164ab19c7c44dc47e3a3546b6a5335fa4e1713631afd8da916f921f9b7c0716' %}
{% set installed_version = salt['cmd.shell']("dpkg -l | grep radare2 | awk '{print $3}'") %}

include:
  - remnux.packages.git

{% if installed_version != '' and installed_version > version %}
Installed Version {{ installed_version }} is higher than intended version:
  test.nop
{% else %}

remnux-radare2-source:
  file.managed:
    - name: /usr/local/src/radare2_{{ version }}_{{ osarch }}.deb
    - source: https://github.com/radareorg/radare2/releases/download/{{ version }}/radare2_{{ version }}_{{ osarch }}.deb
    - source_hash: sha256={{ hash }}

remnux-radare2:
  pkg.installed:
    - sources:
      - radare2: /usr/local/src/radare2_{{ version }}_{{ osarch }}.deb
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

{% endif %}
