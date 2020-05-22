{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.config.user

remnux-theme-sudoers:
  file.append:
    - name: /etc/sudoers.d/remnux
    - text: "remnux ALL=NOPASSWD: ALL"
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}