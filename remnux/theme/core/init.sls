include:
  - remnux.theme.core.gnome-session
  - remnux.theme.core.gdm3
  - remnux.theme.core.guest-tools
  - remnux.theme.core.gnome-terminal
  - remnux.theme.core.gnome-shell-extensions
  - remnux.theme.core.gnome-tweaks


remnux-theme-core:
  test.nop:
    - require:
      - sls: remnux.theme.core.gnome-session
      - sls: remnux.theme.core.gdm3
      - sls: remnux.theme.core.guest-tools
      - sls: remnux.theme.core.gnome-terminal
      - sls: remnux.theme.core.gnome-shell-extensions
      - sls: remnux.theme.core.gnome-tweaks