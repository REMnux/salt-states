nginx:
  pkg.installed

nginx-service:
  service.dead:
    - running: False
    - enable: False
