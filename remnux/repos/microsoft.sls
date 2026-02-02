{% from "remnux/osarch.sls" import osarch with context %}
remnux-microsoft-key:
  file.managed:
    - name: /usr/share/keyrings/MICROSOFT.asc
    - source: https://packages.microsoft.com/keys/microsoft.asc
    - skip_verify: True
    - makedirs: True

remnux-microsoft-repo-cleanup:
  pkgrepo.absent:
    - name: deb https://packages.microsoft.com/ubuntu/{{ grains['lsb_distrib_release'] }}/prod {{ grains['lsb_distrib_codename'] }} main
    - refresh: true

remnux-microsoft-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/microsoft.list

remnux-microsoft-sources-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/microsoft.sources

remnux-microsoft-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/microsoft.sources
    - contents: |
        Types: deb
        URIs: https://packages.microsoft.com/ubuntu/{{ grains['lsb_distrib_release'] }}/prod
        Suites: {{ grains['lsb_distrib_codename'] }}
        Components: main
        Signed-By: /usr/share/keyrings/MICROSOFT.asc
        Architectures: {{ osarch }}
    - require:
      - file: remnux-microsoft-key
      - pkgrepo: remnux-microsoft-repo-cleanup
      - file: remnux-microsoft-list-absent
      - file: remnux-microsoft-sources-absent
