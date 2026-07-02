include:
  - remnux.repos.nodejs

remnux-packages-nodejs:
  pkg.installed:
    - name: nodejs
    - version: latest
    - upgrade: True
    - refresh: True
    - pkgrepo: nodejs
    - require:
      - sls: remnux.repos.nodejs