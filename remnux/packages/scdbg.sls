# Name: scdbg
# Website: http://sandsprite.com/blogs/index.php?uid=7&pid=152
# Description: Analyze shellcode by emulating its execution.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: David Zimmer
# License: Free, unknown license
# Notes: scdbg (GUI), scdbgc (console). Due to a compatibility issue, this tool is not available on an Ubuntu 20.04 SIFT Workstation system to which REMnux was added.

{%- if salt['file.file_exists' ]('/etc/sift-version') and grains['oscodename'] == "focal" %}

remnux-packages-scdbg:
  test.nop

{%- else %}

include:
  - remnux.repos.remnux
  - remnux.packages.wine

remnux-packages-scdbg:
  pkg.installed:
    - version: latest
    - upgrade: True
    - name: scdbg
    - pkgrepo: remnux

{%- endif %}