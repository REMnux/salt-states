include:
  - remnux.packages.openssh

# Marker state so requisite lookups succeed even when other states are skipped
remnux-theme-dedicated:
  test.nop

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

remnux-theme-ssh-regenerate-host-keys:
  cmd.run:
    - name: dpkg-reconfigure openssh-server
    - unless: test -f /etc/ssh/ssh_host_ed25519_key
    - require:
      - sls: remnux.packages.openssh

remnux-theme-ssh-sshd-disable-service:
  service.dead:
    - name: ssh
    - enable: False
    - require:
      - sls: remnux.packages.openssh
      - cmd: remnux-theme-ssh-regenerate-host-keys

remnux-theme-ssh-sshd-disable-socket:
  service.dead:
    - name: ssh.socket
    - enable: False
    - require:
      - sls: remnux.packages.openssh

{% endif %}