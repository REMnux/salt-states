include:
  - remnux.packages.software-properties-common

openjdk-repo:
  pkgrepo.managed:
    - ppa: openjdk-r/ppa
    - refresh: true
    - require:
      - sls: remnux.packages.software-properties-common
