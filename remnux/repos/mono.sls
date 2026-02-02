{% from "remnux/osarch.sls" import osarch with context %}
mono-repo-key:
  file.managed:
    - name: /usr/share/keyrings/mono-official-archive-keyring.pgp
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3fa7e0328081bff6a14da29aa6a19b38d3d831ef
    - skip_verify: True
    - makedirs: True

remnux-mono-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/mono-official-stable.list

remnux-mono-sources-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/mono-official-stable.sources

remnux-mono-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/mono-official-stable.sources
    - contents: |
        Types: deb
        URIs: https://download.mono-project.com/repo/ubuntu
        Suites: stable-focal
        Components: main
        Signed-By: /usr/share/keyrings/mono-official-archive-keyring.pgp
        Architectures: {{ osarch }}
    - require:
      - file: mono-repo-key
      - file: remnux-mono-list-absent
      - file: remnux-mono-sources-absent
