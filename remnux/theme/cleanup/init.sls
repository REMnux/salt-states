remnux-theme-cleanup-autoremove:
  cmd.run:
    - name: apt-get autoremove -y

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control the service
{%- if salt['file.file_exists']('/sbin/runlevel') %}

remnux-theme-cleanup-bluetooth-service:
  service.dead:
    - name: bluetooth
    - enable: False

{% endif %}