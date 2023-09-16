include:
  - remnux.packages.software-properties-common

wireshark-dev-repo-key:
  file.managed:
    - name: /usr/share/keyrings/WIRESHARK-DEV-PGP-KEY.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xa2e402b85a4b70cd78d8a3d9d875551314eca0f0
    - skip_verify: True
    - makedirs: True

wireshark-dev:
  pkgrepo.managed:
    - name: deb [arch=amd64 signed-by=/usr/share/keyrings/WIRESHARK-DEV-PGP-KEY.asc] https://ppa.launchpadcontent.net/wireshark-dev/stable/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - file: /etc/apt/sources.list.d/wireshark-dev-ubuntu-stable-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: true
    - clean_file: True
    - require:
      - sls: remnux.packages.software-properties-common
      - file: wireshark-dev-repo-key
