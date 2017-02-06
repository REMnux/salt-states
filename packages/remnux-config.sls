include:
  - remnux.repos.remnux

remnux-config:
  pkg.installed:
    - require:
      - pkgrepo: remnux
