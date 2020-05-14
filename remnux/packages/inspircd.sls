inspircd:
  pkg.installed

inspircd-service:
  service.dead:
    - name: inspircd
    - enable: False
    - watch:
      - pkg: inspircd