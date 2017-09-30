include:
  - remnux.repos.gift

remnux-packages-libolecf-tools:
  pkg.installed:
    - name: libolecf-tools
    - require:
      - pkgrepo: gift-repo
