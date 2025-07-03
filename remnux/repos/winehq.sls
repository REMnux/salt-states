winehq-repo-key:
  file.managed:
    - name: /usr/share/keyrings/winehq-archive.pgp
    - source: https://dl.winehq.org/wine-builds/winehq.key
    - skip_verify: True
    - makedirs: True
    - replace: True

winehq-repo:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/winehq-archive.pgp] https://dl.winehq.org/wine-builds/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - file: /etc/apt/sources.list.d/winehq-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: winehq-repo-key
