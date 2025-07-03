{% from "remnux/osarch.sls" import osarch with context %}
include:
  - remnux.packages.software-properties-common

openjdk-repo-key:
  file.managed:
    - name: /usr/share/keyrings/OPENJDK-PGP-KEY.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf7c313db11f1ed148bb5117c08b3810cb7017b89
    - skip_verify: True
    - makedirs: True

openjdk-repo:
  pkgrepo.managed:
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/OPENJDK-PGP-KEY.asc] https://ppa.launchpadcontent.net/openjdk-r/ppa/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - file: /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: true
    - clean_file: True
    - require:
      - sls: remnux.packages.software-properties-common
      - file: openjdk-repo-key
