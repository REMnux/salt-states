{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.config.user

remnux-theme-sudoers:
  file.append:
    - name: /etc/sudoers.d/remnux
    - text: "{{ user }} ALL=NOPASSWD: ALL\nDefaults env_keep += \"ftp_proxy http_proxy https_proxy no_proxy\""
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}