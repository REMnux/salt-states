include:
  - remnux.repos.remnux

remnux-dshell:
  pkg.installed:
    - require:
      - pkgrepo: remnux
