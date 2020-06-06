inspircd:
  pkg.installed

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

inspircd-service:
  service.dead:
    - name: inspircd
    - enable: False
    - watch:
      - pkg: inspircd


{% endif %}