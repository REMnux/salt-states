{%- set version = salt['grains.get']('remnux_version', 'stable') -%}

{%- if version == "stable" %}

remnux-dev:
  pkgrepo.absent:
    - ppa: remnux/dev

{%- else %}

remnux-stable:
  pkgrepo.absent:
    - ppa: remnux/stable

{%- endif %}

remnux-repo:
  pkgrepo.managed:
    - ppa: remnux/{{ version }}
    - refresh: true
    - keyid_ppa: true
