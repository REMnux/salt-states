include:
  - remnux.theme.gnome-config.init

/usr/share/remnux:
  file.symlink:
  - target: /usr/local/share/remnux
  - require:
    - sls: remnux.theme.gnome-config.init