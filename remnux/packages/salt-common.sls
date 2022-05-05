include:
  - remnux.repos.saltstack

remnux-packages-salt-common:
  pkg.installed:
    - name: salt-common
    - version: latest
    - upgrade: True
    - pkgrepo: saltstack