{%- set version = salt['grains.get']('remnux_version', 'stable') -%}

{%- if version == "stable" %}

sift-dev:
  pkgrepo.absent:
    - ppa: sift/dev

{%- else %}

sift-stable:
  pkgrepo.absent:
    - ppa: sift/stable

{%- endif %}

sift-repo-key:
  file.managed:
    - name: /usr/share/keyrings/SIFT-GPG-KEY.asc
    - source: salt://remnux/repos/files/SIFT-GPG-KEY.asc
    - skip_verify: True
    - makedirs: True

sift-repo:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/SIFT-GPG-KEY.asc] https://ppa.launchpadcontent.net/sift/stable/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - file: /etc/apt/sources.list.d/sift-stable-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: sift-repo-key
