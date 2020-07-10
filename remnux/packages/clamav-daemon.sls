# Name: ClamAV
# Website: https://www.clamav.net
# Description: Scan files for malware signatures.
# Category: Examine Static Properties: PE Files, Statically Analyze Code: Unpacking
# Author: https://www.clamav.net/about
# License: GNU General Public License (GPL): https://www.clamav.net/about
# Notes: clamscan, freshclam

clamav-daemon:
  pkg.installed

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

clamav-daemon-service:
  service.dead:
    - name: clamav-daemon
    - enable: False
    - watch:
      - pkg: clamav-daemon

clamav-freshclam-service:
  service.dead:
    - name: clamav-freshclam
    - enable: False
    - watch:
      - pkg: clamav-daemon

{% endif %}