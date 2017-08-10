include:
  - remnux.repos.sift

python-volatility:
  pkg.installed:
    - require:
      - pkgrepo: sift
