tor:
  pkg.installed

tor-service:
  service.dead:
    - enable: False
    - watch:
      - pkg: tor
