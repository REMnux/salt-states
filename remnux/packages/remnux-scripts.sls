include:
  - remnux.repos.remnux

remnux-scripts:
  pkg.installed:
    - require:
      - pkgrepo: remnux
