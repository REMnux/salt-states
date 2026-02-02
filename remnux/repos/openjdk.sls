include:
  - remnux.packages.software-properties-common

remnux-remove-openjdk-list:
  file.absent:
    - name: /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-{{ grains['lsb_distrib_codename'] }}.list
    - require_in:
      - pkgrepo: openjdk-repo

remnux-remove-openjdk-key:
  file.absent:
    - name: /usr/share/keyrings/OPENJDK-GPG-KEY.asc
    - require_in:
      - pkgrepo: openjdk-repo

openjdk-repo:
  pkgrepo.managed:
    - ppa: openjdk-r/ppa
    - keyid: DA1A4A13543B466853BAF164EB9B1D8886F44E2A
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: remnux.packages.software-properties-common
