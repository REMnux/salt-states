include:
  - remnux.repos.remnux

remnux-rules:
  pkg.installed:
    - require:
      - pkgrepo: remnux
