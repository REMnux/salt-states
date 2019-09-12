include:
  - remnux.packages.software-properties-common

openjdk-repo:
  pkgrepo.managed:
    - ppa: openjdk-r/ppa
    - refresh_db: true
    - require:
      - sls: remnux.packages.software-properties-common
