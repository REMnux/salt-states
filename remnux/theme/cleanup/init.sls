include:
  - remnux.cleanup.gnome-user-docs

remnux-theme-cleanup:
  test.nop:
    - require:
      - sls: remnux.cleanup.gnome-user-docs