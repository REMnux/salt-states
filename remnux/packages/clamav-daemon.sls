# Name: ClamAV
# Website: https://www.clamav.net
# Description: Scan files for malware signatures.
# Category: File Properties and Contents: Scan
# Author: https://www.clamav.net/about
# License: https://www.clamav.net/about
# Notes: Run "freshclam" to download and update signatures.

clamav-daemon:
  pkg.installed

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
