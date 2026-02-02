{% from "remnux/osarch.sls" import osarch with context %}

remnux-nodejs-key:
  file.managed:
    - name: /usr/share/keyrings/NODESOURCE-GPG.KEY
    - source: https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key
    - skip_verify: True
    - makedirs: True

nodejs-repo-cleanup:
  pkgrepo.absent:
    - name: deb https://deb.nodesource.com/node_22.x {{ grains['lsb_distrib_codename'] }} main
    - refresh: true

remnux-nodejs-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/nodesource.list

remnux-nodejs-sources-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/nodesource.sources

remnux-nodejs-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/nodesource.sources
    - contents: |
        Types: deb
        URIs: https://deb.nodesource.com/node_22.x
        Suites: nodistro
        Components: main
        Signed-By: /usr/share/keyrings/NODESOURCE-GPG.KEY
        Architectures: {{ osarch }}
    - require:
      - file: remnux-nodejs-key
      - pkgrepo: nodejs-repo-cleanup
      - file: remnux-nodejs-list-absent
      - file: remnux-nodejs-sources-absent
