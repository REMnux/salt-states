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
