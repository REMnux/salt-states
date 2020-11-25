# Name: ProcDOT
# Website: https://www.procdot.com
# Description: Visualize and examine the output of Process Monitor.
# Category: Investigate System Interactions
# Author: Christian Wojner: https://twitter.com/Didelphodon
# License: Free, custom license: https://cert.at/media/files/downloads/software/procdot/files/license.txt
# Notes: procdot

include:
  - remnux.repos.remnux

procdot:
  pkg.installed

{%- if grains['oscodename'] == "focal" %}

procdot-link:
  file.symlink:
    - name: /usr/lib/x86_64-linux-gnu/libwebkitgtk-3.0.so.0
    - target: /usr/lib/x86_64-linux-gnu/libwebkit2gtk-4.0.so.37
    - watch:
      - pkg: procdot

{% endif %}