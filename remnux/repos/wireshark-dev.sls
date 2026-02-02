{% from "remnux/osarch.sls" import osarch with context %}
wireshark-dev-repo-key:
  file.managed:
    - name: /usr/share/keyrings/WIRESHARK-DEV-PGP-KEY.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xa2e402b85a4b70cd78d8a3d9d875551314eca0f0
    - skip_verify: True
    - makedirs: True

wireshark-repo-cleanup:
  pkgrepo.absent:
    - ppa: wireshark-dev/stable
    - refresh: true

remnux-wireshark-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/wireshark-dev-ubuntu-stable-{{ grains['lsb_distrib_codename'] }}.list

remnux-wireshark-sources-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/wireshark-dev-ubuntu-stable-{{ grains['lsb_distrib_codename'] }}.sources

wireshark-dev:
  file.managed:
    - name: /etc/apt/sources.list.d/wireshark-dev-ubuntu-stable-{{ grains['lsb_distrib_codename'] }}.sources
    - contents: |
        Types: deb
        URIs: https://ppa.launchpadcontent.net/wireshark-dev/stable/ubuntu
        Suites: {{ grains['lsb_distrib_codename'] }}
        Components: main
        Signed-By: /usr/share/keyrings/WIRESHARK-DEV-PGP-KEY.asc
        Architectures: {{ osarch }}
    - require:
      - file: wireshark-dev-repo-key
      - pkgrepo: wireshark-repo-cleanup
      - file: remnux-wireshark-list-absent
      - file: remnux-wireshark-sources-absent
