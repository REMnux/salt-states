{% from "remnux/osarch.sls" import osarch with context %}
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
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x93465001dc4c8a3fcbbcfe263a43288ee0ab26fb
    - skip_verify: True
    - makedirs: True

sift-repo:
  pkgrepo.managed:
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/SIFT-GPG-KEY.asc] https://ppa.launchpadcontent.net/sift/stable/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - file: /etc/apt/sources.list.d/sift-stable-{{ grains['lsb_distrib_codename'] }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: sift-repo-key
