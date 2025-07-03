{% from "remnux/osarch.sls" import osarch with context %}
mono-repo-key:
  file.managed:
    - name: /usr/share/keyrings/mono-official-archive-keyring.pgp
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3fa7e0328081bff6a14da29aa6a19b38d3d831ef
    - skip_verify: True
    - makedirs: True

mono-repo:
  pkgrepo.managed:
    - humanname: Mono
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/mono-official-archive-keyring.pgp] https://download.mono-project.com/repo/ubuntu stable-focal main
    - file: /etc/apt/sources.list.d/mono-official-stable.list
    - refresh: True
    - clean_file: True
    - require:
      - file: mono-repo-key
