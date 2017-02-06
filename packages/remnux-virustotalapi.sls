include:
  - remnux.repos.remnux

remnux-virustotalapi:
  pkg.installed:
    - require:
      - pkgrepo: remnux
