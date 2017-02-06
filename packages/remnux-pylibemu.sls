include:
  - remnux.repos.remnux

remnux-pylibemu:
  pkg.installed:
    - require:
      - pkgrepo: remnux
