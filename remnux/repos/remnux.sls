{% from "remnux/osarch.sls" import osarch with context %}
remnux-repo-key:
  file.managed:
    - name: /usr/share/keyrings/REMNUX-GPG-KEY.asc
    - source: salt://remnux/repos/files/REMNUX-GPG-KEY.asc
    - skip_verify: True
    - makedirs: True

remnux-repo:
  pkgrepo.managed:
    - name: deb [arch={{ osarch}} signed-by=/usr/share/keyrings/REMNUX-GPG-KEY.asc] https://ppa.launchpadcontent.net/remnux/stable/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - file: /etc/apt/sources.list.d/remnux-stable-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: remnux-repo-key
