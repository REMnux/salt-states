include:
  - remnux.repos.pgadmin4
  - remnux.packages.apt-utils

remnux-packages-pgadmin4:
  pkg.installed:
    - name: pgadmin4-desktop
    - require:
      - sls: remnux.repos.pgadmin4
      - sls: remnux.packages.apt-utils
