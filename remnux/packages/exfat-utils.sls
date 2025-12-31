# Name: exfat-utils
# Website: https://github.com/relan/exfat
# Description: Free exFAT File System Implementation.
# Category:
# Author: Relan
# License: GNU General Public License v2 (https://github.com/relan/exfat/blob/master/COPYING)
# Notes:

remnux-packages-exfat-utils:
  pkg.installed:
  {% if grains['oscodename'] == "focal" %}
    - name: exfat-utils
  {% elif grains['oscodename'] == "noble" %}
    - name: exfatprogs
  {% endif %}
