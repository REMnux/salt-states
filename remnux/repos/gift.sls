{% from "remnux/osarch.sls" import osarch with context %}
gift-ppa-stable-absent:
  pkgrepo.absent:
    - ppa: gift/stable

gift-ppa-dev-absent:
  pkgrepo.absent:
    - ppa: gift/dev

gift-deb822-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/gift-ubuntu-stable-{{ grains['lsb_distrib_codename'] }}.sources

gift-deb822-dev-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/gift-ubuntu-dev-{{ grains['lsb_distrib_codename'] }}.sources

remnux-gift-key:
  file.managed:
    - name: /usr/share/keyrings/GIFT-GPG-KEY.asc
    - source: salt://remnux/repos/files/GIFT-GPG-KEY.asc
    - skip_verify: True
    - makedirs: True

gift-repo:
  pkgrepo.managed:
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/GIFT-GPG-KEY.asc] https://ppa.launchpadcontent.net/gift/stable/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/gift-ubuntu-stable-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: remnux-gift-key
      - pkgrepo: gift-ppa-stable-absent
      - pkgrepo: gift-ppa-dev-absent
      - file: gift-deb822-absent
      - file: gift-deb822-dev-absent
