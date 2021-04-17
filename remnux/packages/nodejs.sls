include:
  - remnux.repos.nodejs

remnux-packages-nodejs:
  pkg.installed:
    - name: nodejs
    - version: latest
    - upgrade: True
    - pkgrepo: nodejs