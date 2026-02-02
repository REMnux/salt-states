include:
  - remnux.packages.software-properties-common

remnux-repo:
  pkgrepo.managed:
    - name: remnux
    - ppa: remnux/stable
    - keyid: E90F33EEF615660D25A02D32BFF45016788DE115
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: remnux.packages.software-properties-common
