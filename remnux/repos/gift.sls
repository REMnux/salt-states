remnux-gift-key:
  file.managed:
    - name: /usr/share/keyrings/GIFT-GPG-KEY.asc
    - source: salt://remnux/repos/files/GIFT-GPG-KEY.asc
    - skip_verify: True
    - makedirs: True

gift-repo:
  pkgrepo.managed:
    - name: deb [arch=amd64 signed-by=/usr/share/keyrings/GIFT-GPG-KEY.asc] http://ppa.launchpad.net/gift/stable/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/gift-ubuntu-stable-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: remnux-gift-key
