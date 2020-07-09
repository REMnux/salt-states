include:
  - remnux.packages.openssh

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

remnux-theme-ssh-sshd-disable-service:
  service.dead:
    - name: ssh
    - enable: False
    - require:
      - sls: remnux.packages.openssh

{% endif %}