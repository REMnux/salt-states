include:
  - remnux.repos.draios

sysdig:
  pkg.installed:
    - require:
      - pkgrepo: draios
