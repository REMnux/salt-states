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

sift-repo:
  pkgrepo.managed:
    - ppa: sift/{{ version }}
    - refresh: true
    # Source - https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xb2a668dd0744bec3
    - key_url: salt://remnux/repos/files/SIFT-GPG-KEY.asc
    - gpgcheck: 1