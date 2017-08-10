include:
  - remnux.repos.remnux
  - remnux.packages.python-volatility

remnux-volatility-plugins:
  pkg.installed:
    - require:
      - pkgrepo: remnux
      - pkg: python-volatility
