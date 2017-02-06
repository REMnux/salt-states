include:
  - remnux.repos.remnux

remnux-network-miner:
  pkg.installed:
    - require:
      - pkgrepo: remnux
