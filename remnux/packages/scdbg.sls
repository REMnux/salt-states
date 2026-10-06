# Name: scdbg
# Website: http://sandsprite.com/blogs/index.php?uid=7&pid=152
# Description: Analyze shellcode by emulating its execution.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: David Zimmer
# License: Free, unknown license
# Notes: scdbg (GUI), scdbgc (console).

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-packages-scdbg-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: scdbg is not available for this architecture."

{% else %}

include:
  - remnux.repos.remnux
  - remnux.packages.wine

remnux-packages-scdbg:
  pkg.installed:
    - version: latest
    - upgrade: True
    - name: scdbg
    - pkgrepo: remnux

{% endif %}
