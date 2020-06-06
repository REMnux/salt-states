stunnel4:
  pkg.installed

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

stunnel4-service:
  service.dead:
    - name: stunnel4
    - enable: False
    - watch:
      - pkg: stunnel4

{% endif %}