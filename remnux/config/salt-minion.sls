# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

remnux-config-salt-minion:
  service.dead:
    - name: salt-minion
    - enable: False

{% endif %}

remnux-config-salt-minion-placeholder:
  test.nop