include:
  - remnux.repos.sift
  - remnux.repos.openjdk

bulk-extractor:
  pkg.installed:
    - require:
      - pkgrepo: sift-repo
      - pkgrepo: openjdk-repo
