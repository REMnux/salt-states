include:
  - remnux.repos.remnux

remnux-bashacks:
  pkg.installed:
    - require:
      - pkgrepo: remnux
