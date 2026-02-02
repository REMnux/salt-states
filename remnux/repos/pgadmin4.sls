{% from "remnux/osarch.sls" import osarch with context %}
pgadmin4-repo-key:
  file.managed:
    - name: /usr/share/keyrings/packages-pgadmin-org.pgp
    - source: https://www.pgadmin.org/static/packages_pgadmin_org.pub
    - skip_verify: True
    - replace: True
    - makedirs: True

remnux-pgadmin4-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/pgadmin4-{{ grains['lsb_distrib_codename'] }}.list

remnux-pgadmin4-sources-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/pgadmin4-{{ grains['lsb_distrib_codename'] }}.sources

remnux-pgadmin4-repo-cleanup:
  pkgrepo.absent:
    - name: deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/{{ grains['lsb_distrib_codename'] }} pgadmin4 main

remnux-pgadmin4-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/pgadmin4-{{ grains['lsb_distrib_codename'] }}.sources
    - contents: |
        Types: deb
        URIs: https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/{{ grains['lsb_distrib_codename'] }}
        Suites: pgadmin4
        Components: main
        Signed-By: /usr/share/keyrings/packages-pgadmin-org.pgp
        Architectures: {{ osarch }}
    - require:
      - file: pgadmin4-repo-key
      - file: remnux-pgadmin4-list-absent
      - file: remnux-pgadmin4-sources-absent
      - pkgrepo: remnux-pgadmin4-repo-cleanup
