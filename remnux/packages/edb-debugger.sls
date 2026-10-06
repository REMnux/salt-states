# Name: edb
# Website: https://github.com/eteran/edb-debugger
# Description: An AArch32/x86/x86-64 debugger, well suited for debugging ELF files.
# Category: Dynamically Reverse-Engineer Code: ELF Files
# Author: Evan Teran: https://github.com/eteran
# License: GNU General Public License (GPL) v2: https://github.com/eteran/edb-debugger/blob/master/COPYING
# Notes: 

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-packages-edb-debugger-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: edb is not available for this architecture."

{% else %}

include:
  - remnux.repos.remnux
  - remnux.packages.xterm
  
edb-debugger:
  pkg.installed:
    - pkgrepo: remnux
    - version: latest
    - upgrade: True
    - require:
      - sls: remnux.packages.xterm

{% endif %}
