include:
  - remnux.theme.core.init
  - remnux.theme.gnome-config.init
  - remnux.theme.compatibility
  - remnux.theme.autologin
  - remnux.theme.sudoers
  - remnux.theme.cleanup

remnux-theme:
  test.nop:
    - require:
      - sls: remnux.theme.core.init
      - sls: remnux.theme.gnome-config.init
      - sls: remnux.theme.compatibility
      - sls: remnux.theme.autologin
      - sls: remnux.theme.sudoers
      - sls: remnux.theme.cleanup