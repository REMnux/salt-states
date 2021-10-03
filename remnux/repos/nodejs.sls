nodejs-repo:
  pkgrepo.managed:
    - humanname: nodejs
    - name: deb http://deb.nodesource.com/node_14.x {{ grains['lsb_distrib_codename'] }} main
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: http://deb.nodesource.com/gpgkey/nodesource.gpg.key
    - gpgcheck: 1
    - refresh: true
