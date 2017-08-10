inspircd:
  pkg.installed

inspircd-service:
  service.dead:
    - enable: False
    - watch:
      - pkg: inspircd
