include:
  - remnux.packages.software-properties-common

remnux-remove-remnux-list:
  file.absent:
    - name: /etc/apt/sources.list.d/remnux-stable-{{ grains['lsb_distrib_codename'] }}.list
    - require_in:
      - pkgrepo: remnux-repo

remnux-remove-remnux-key:
  file.absent:
    - name: /usr/share/keyrings/REMNUX-GPG-KEY.asc
    - require_in:
      - pkgrepo: remnux-repo

remnux-repo:
  pkgrepo.managed:
    - name: remnux
    - ppa: remnux/stable
    - keyid: E90F33EEF615660D25A02D32BFF45016788DE115
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: remnux.packages.software-properties-common
