{% from "remnux/osarch.sls" import osarch with context %}
pgadmin4-repo-key:
  file.managed:
    - name: /usr/share/keyrings/packages-pgadmin-org.pgp
    - source: https://www.pgadmin.org/static/packages_pgadmin_org.pub
    - skip_verify: True
    - replace: True
    - makedirs: True
    
pgadmin4-repo:
  pkgrepo.managed:
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/packages-pgadmin-org.pgp] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/{{ grains['lsb_distrib_codename'] }} pgadmin4 main
    - file: /etc/apt/sources.list.d/pgadmin4-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: pgadmin4-repo-key

