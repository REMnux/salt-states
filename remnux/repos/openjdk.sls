include:
  - remnux.packages.python-software-properties

openjdk-repo:
  pkgrepo.managed:
    - ppa: openjdk-r/ppa
    - refresh_db: true
    - require:
      - sls: remnux.packages.python-software-properties
