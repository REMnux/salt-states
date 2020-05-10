{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.theme.core.gdm3

remnux-theme-autologin-true:
  file.replace:
    - name: /etc/gdm3/custom.conf
    - pattern: '#  AutomaticLoginEnable = true'
    - repl: 'AutomaticLoginEnable = true'
    - prepend_if_not_found: True
    - count: 1
    - require:
      - sls: remnux.theme.core.gdm3

remnux-theme-autologin-user:
  file.replace:
    - name: /etc/gdm3/custom.conf
    - pattern: '#  AutomaticLogin = user1'
    - repl: '#  AutomaticLogin = {{ user }}'
    - prepend_if_not_found: True
    - count: 1
    - watch:
      - file: remnux-theme-autologin-true