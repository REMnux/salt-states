include:
  - remnux.theme.cleanup.gnome-user-docs

remnux-theme-cleanup:
  test.nop:
    - require:
      - sls: remnux.theme.cleanup.gnome-user-docs

remnux-theme-cleanup-autoremove:
  cmd.run:
    - name: apt-get autoremove -y