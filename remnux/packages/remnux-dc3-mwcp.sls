include:
  - remnux.repos.remnux

remnux-dc3-mwcp:
  pkg.installed:
    - require:
      - pkgrepo: remnux
