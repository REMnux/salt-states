{% from "remnux/osarch.sls" import osarch with context %}
winehq-repo-key:
  file.managed:
    - name: /usr/share/keyrings/winehq-archive.pgp
    - source: https://dl.winehq.org/wine-builds/winehq.key
    - skip_verify: True
    - makedirs: True
    - replace: True

winehq-repo-cleanup:
  pkgrepo.absent:
    - name: deb https://dl.winehq.org/wine-builds/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - refresh: true

remnux-winehq-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/winehq-{{ grains['lsb_distrib_codename'] }}.list

remnux-winehq-sources-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/winehq-{{ grains['lsb_distrib_codename'] }}.sources

remnux-winehq-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/winehq-{{ grains['lsb_distrib_codename'] }}.sources
    - contents: |
        Types: deb
        URIs: https://dl.winehq.org/wine-builds/ubuntu
        Suites: {{ grains['lsb_distrib_codename'] }}
        Components: main
        Signed-By: /usr/share/keyrings/winehq-archive.pgp
        Architectures: amd64 i386
    - require:
      - file: winehq-repo-key
      - pkgrepo: winehq-repo-cleanup
      - file: remnux-winehq-list-absent
      - file: remnux-winehq-sources-absent
