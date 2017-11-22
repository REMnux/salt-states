include:
  - remnux.repos.draios
  - remnux.packages.linux-headers

remnux-sysdig:
  pkg.installed:
    - name: sysdig
    - require:
      - pkgrepo: draios
      - pkg: remnux-linux-headers
